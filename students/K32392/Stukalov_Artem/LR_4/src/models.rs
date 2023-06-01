use serde::{Deserialize, Serialize};

use crate::schema::meetings;

#[derive(Debug, Serialize, Deserialize, Queryable)]
pub struct Meeting {
  pub id: i32,
  pub title: String,
  pub invite_text: String,
  pub start_at: chrono::NaiveDateTime,
  pub peer_id: i32,
}

#[derive(Debug, Insertable)]
#[table_name = "meetings"]
pub struct NewMeeting<'a> {
  pub title: &'a str,
  pub invite_text: &'a str,
  pub start_at: chrono::NaiveDateTime,
  pub peer_id: &'a i32,
}

#[derive(Debug, AsChangeset)]
#[table_name = "meetings"]
pub struct UpdateMeeting<'a> {
  pub title: Option<&'a str>,
  pub invite_text: Option<&'a str>,
  pub start_at: Option<chrono::NaiveDateTime>,
  pub peer_id: Option<&'a i32>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct MeetingPayload {
  pub title: String,
  pub invite_text: String,
  pub peer_id: i32,
  pub start_at: i64,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct MeetingUpdatePayload {
  pub title: Option<String>,
  pub invite_text: Option<String>,
  pub peer_id: Option<i32>,
  pub start_at: Option<i64>,
}
