use flutter_rust_bridge::frb;
use lofty::tag::{Accessor, Tag};

#[frb(dart_metadata=("immutable" import "package:meta/meta.dart"))]
pub struct Disc {
  pub total: Option<u32>,
  pub number: Option<u32>,
}

impl Disc {
  #[frb(ignore)]
  pub fn from_tag(tag: &Tag) -> Option<Disc> {
    let number = tag.disk();
    let total = tag.disk_total();

    match (total, number) {
      (None, None) => None,
      (total, number) => Some(Disc { total, number }),
    }
  }
}
