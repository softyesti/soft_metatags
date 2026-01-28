use crate::api::entities::{meta::Meta, song::Song};
use flutter_rust_bridge::frb;
use lofty::{
  file::{AudioFile, TaggedFileExt},
  read_from_path,
};

#[frb(init)]
pub fn init_app() {
  flutter_rust_bridge::setup_default_user_utils();
}

pub fn read(path: &String) -> Option<Song> {
  let file = read_from_path(path).ok()?;

  let tag = file.primary_tag();
  let duration = file.properties().duration();

  match tag {
    None => Some(Song::new(path, duration, None)),
    Some(tag) => Some(Song::new(path, duration, Some(Meta::from_tag(&tag)))),
  }
}
