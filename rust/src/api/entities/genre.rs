use crate::api::utils::split_string;
use flutter_rust_bridge::frb;
use lofty::tag::{Accessor, Tag};

#[frb(dart_metadata=("immutable" import "package:meta/meta.dart"))]
pub struct Genre {
  pub name: Option<String>,
}

impl From<&String> for Genre {
  fn from(name: &String) -> Self {
    Genre {
      name: Some(name.to_string()),
    }
  }
}

impl Genre {
  #[frb(ignore)]
  pub fn from_tag(tag: &Tag) -> Option<Vec<Genre>> {
    let genre = tag.genre().map(|g| g.to_string());
    if genre.is_none() {
      return None;
    }

    let collection = split_string(&genre.unwrap());
    let genres = collection.iter().filter_map(|g| Some(Genre::from(g)));

    Some(genres.collect())
  }
}
