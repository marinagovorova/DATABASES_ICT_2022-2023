use super::DbPool;

use actix_web::{delete, get, post, put, web, Error, HttpResponse};
use diesel::prelude::*;

use crate::models::{Meeting, MeetingPayload, MeetingUpdatePayload, NewMeeting, UpdateMeeting};

type DbError = Box<dyn std::error::Error + Send + Sync>;

#[get("/meetings")]
async fn list(pool: web::Data<DbPool>) -> Result<HttpResponse, Error> {
  let meetings = web::block(move || {
    let mut conn = pool.get()?;
    find_all_meetings(&mut conn)
  })
  .await?
  .map_err(actix_web::error::ErrorInternalServerError)?;

  Ok(HttpResponse::Ok().json(meetings))
}

#[get("/meetings/{id}")]
async fn get_single(id: web::Path<i32>, pool: web::Data<DbPool>) -> Result<HttpResponse, Error> {
  let meeting = web::block(move || {
    let mut conn = pool.get()?;
    find_meeting_by_id(&mut conn, id.into_inner())
  })
  .await?
  .map_err(actix_web::error::ErrorInternalServerError)?;

  Ok(HttpResponse::Ok().json(meeting))
}

#[post("/meetings")]
async fn create(
  pool: web::Data<DbPool>,
  payload: web::Json<MeetingPayload>,
) -> Result<HttpResponse, Error> {
  let meeting = web::block(move || {
    let mut conn = pool.get()?;
    create_meeting(
      &mut conn,
      &payload.title,
      &payload.invite_text,
      &payload.peer_id,
      &payload.start_at,
    )
  })
  .await?
  .map_err(actix_web::error::ErrorInternalServerError)?;

  Ok(HttpResponse::Ok().json(meeting))
}

#[put("/meetings/{id}")]
async fn update(
  id: web::Path<i32>,
  payload: web::Json<MeetingUpdatePayload>,
  pool: web::Data<DbPool>,
) -> Result<HttpResponse, Error> {
  let meeting = web::block(move || {
    let mut conn = pool.get()?;
    update_meeting(
      &mut conn,
      id.into_inner(),
      &UpdateMeeting {
        title: payload.title.clone().as_deref(),
        invite_text: payload.invite_text.clone().as_deref(),
        start_at: unwrap_option_time(payload.start_at),
        peer_id: payload.peer_id.as_ref(),
      },
    )
  })
  .await?
  .map_err(actix_web::error::ErrorInternalServerError)?;

  Ok(HttpResponse::Ok().json(meeting))
}

fn unwrap_option_time(data: Option<i64>) -> Option<chrono::NaiveDateTime> {
  match data {
    Some(v) => Some(chrono::NaiveDateTime::from_timestamp_opt(v, 0).expect("")),
    None => None,
  }
}

#[delete("/meetings/{id}")]
async fn destroy(id: web::Path<i32>, pool: web::Data<DbPool>) -> Result<HttpResponse, Error> {
  let result = web::block(move || {
    let mut conn = pool.get()?;
    delete_meeting(&mut conn, id.into_inner())
  })
  .await?
  .map(|meeting| HttpResponse::Ok().json(meeting))
  .map_err(actix_web::error::ErrorInternalServerError)?;

  Ok(result)
}

fn find_all_meetings(conn: &mut PgConnection) -> Result<Vec<Meeting>, DbError> {
  use crate::schema::meetings::dsl::*;

  let items = meetings.load::<Meeting>(conn)?;
  Ok(items)
}

fn find_meeting_by_id(conn: &mut PgConnection, _id: i32) -> Result<Option<Meeting>, DbError> {
  use crate::schema::meetings::dsl::*;

  let meeting = meetings
    .filter(id.eq(_id))
    .first::<Meeting>(conn)
    .optional()?;

  Ok(meeting)
}

fn create_meeting(
  conn: &mut PgConnection,
  _title: &str,
  _invite_text: &str,
  _peer_id: &i32,
  _start_at: &i64,
) -> Result<Meeting, DbError> {
  use crate::schema::meetings::dsl::*;

  let new_meeting = NewMeeting {
    title: _title,
    invite_text: _invite_text,
    start_at: chrono::NaiveDateTime::from_timestamp_opt(*_start_at, 0).expect(""),
    peer_id: _peer_id,
  };

  let res = diesel::insert_into(meetings)
    .values(&new_meeting)
    .get_result(conn)?;
  Ok(res)
}

fn update_meeting(
  conn: &mut PgConnection,
  _id: i32,
  update_data: &UpdateMeeting,
) -> Result<Meeting, DbError> {
  use crate::schema::meetings::dsl::*;

  let meeting = diesel::update(meetings.find(_id))
    .set(update_data)
    .get_result::<Meeting>(conn)?;
  Ok(meeting)
}

fn delete_meeting(conn: &mut PgConnection, _id: i32) -> Result<usize, DbError> {
  use crate::schema::meetings::dsl::*;

  let count = diesel::delete(meetings.find(_id)).execute(conn)?;
  Ok(count)
}
