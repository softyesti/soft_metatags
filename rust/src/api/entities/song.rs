use crate::api::{entities::meta::Meta, utils::extract_filename};
use flutter_rust_bridge::frb;
use std::time::Duration;

pub struct Song {
  pub path: String,
  pub title: String,
  pub duration: u64,
  pub meta: Option<Meta>,
}

impl Song {
  #[frb(ignore)]
  pub fn new(path: &String, duration: Duration, meta: Option<Meta>) -> Self {
    Song {
      meta,
      path: path.to_string(),
      duration: duration.as_secs(),
      title: extract_filename(&path),
    }
  }
}
