#[macro_use]
extern crate diesel;

use actix_web::{middleware, web, App, HttpServer};
use diesel::prelude::*;
use diesel::r2d2::{self, ConnectionManager};
use dotenv::dotenv;

pub type DbPool = r2d2::Pool<ConnectionManager<PgConnection>>;

mod handlers;
mod models;
mod schema;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
  dotenv().ok();

  env_logger::init_from_env(env_logger::Env::new().default_filter_or("info"));

  let database_url = std::env::var("DATABASE_URL").expect("DATABASE_URL should be set");
  let manager = ConnectionManager::<PgConnection>::new(database_url);
  let pool: DbPool = r2d2::Pool::builder()
    .build(manager)
    .expect("Failed to create pool");

  HttpServer::new(move || {
    App::new()
      .app_data(web::Data::new(pool.clone()))
      .wrap(middleware::Logger::default())
      .service(handlers::list)
      .service(handlers::create)
      .service(handlers::get_single)
      .service(handlers::update)
      .service(handlers::destroy)
  })
  .bind(("localhost", 8080))?
  .run()
  .await
}
