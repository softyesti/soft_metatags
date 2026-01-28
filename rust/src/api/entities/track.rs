use flutter_rust_bridge::frb;
use lofty::tag::{Accessor, Tag};

#[frb(dart_metadata=("immutable" import "package:meta/meta.dart"))]
pub struct Track {
  pub total: Option<u32>,
  pub number: Option<u32>,
}

impl From<&Tag> for Track {
  fn from(tag: &Tag) -> Self {
    let number = tag.track();
    let total = tag.track_total();

    Track { total, number }
  }
}

impl Track {
  #[frb(ignore)]
  pub fn from_tag(tag: &Tag) -> Option<Track> {
    let number = tag.track();
    let total = tag.track_total();

    match (total, number) {
      (None, None) => None,
      (total, number) => Some(Track { total, number }),
    }
  }
}
