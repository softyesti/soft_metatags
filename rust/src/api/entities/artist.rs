use crate::api::utils::split_string;
use flutter_rust_bridge::frb;
use lofty::{
  picture::PictureType,
  tag::{Accessor, Tag},
};

#[frb(dart_metadata=("immutable" import "package:meta/meta.dart"))]
pub struct Artist {
  pub name: Option<String>,
  pub picture: Option<Vec<u8>>,
}

impl From<&String> for Artist {
  fn from(name: &String) -> Self {
    Artist {
      name: Some(name.to_string()),
      picture: None,
    }
  }
}

impl Artist {
  #[frb(ignore)]
  pub fn from_tag(tag: &Tag) -> Option<Vec<Artist>> {
    let artist = tag.artist().map(|a| a.to_string());
    if artist.is_none() {
      return None;
    }

    let collection = split_string(&artist.unwrap());
    let artists = collection
      .iter()
      .enumerate()
      .filter_map(|(i, a)| map_artist(i, a, tag));

    Some(artists.collect())
  }
}

fn map_artist(i: usize, a: &String, tag: &Tag) -> Option<Artist> {
  if i == 0 {
    let picture = tag.get_picture_type(PictureType::Artist);

    return Some(Artist {
      name: Some(a.to_string()),
      picture: picture.map(|p| p.data().to_vec()),
    });
  }

  return Some(Artist::from(a));
}
