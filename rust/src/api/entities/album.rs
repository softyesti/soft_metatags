use crate::api::{entities::artist::Artist, utils::split_string};
use flutter_rust_bridge::frb;
use lofty::{
  picture::PictureType,
  tag::{Accessor, Tag},
};

#[frb(dart_metadata=("immutable" import "package:meta/meta.dart"))]
pub struct Album {
  pub title: Option<String>,
  pub artwork: Option<Vec<u8>>,
  pub artists: Option<Vec<Artist>>,
}

impl From<&String> for Album {
  fn from(title: &String) -> Self {
    Album {
      title: Some(title.to_string()),
      artwork: None,
      artists: None,
    }
  }
}

impl Album {
  #[frb(ignore)]
  pub fn from_tag(tag: &Tag) -> Option<Vec<Album>> {
    let album = tag.album().map(|a| a.to_string());
    if album.is_none() {
      return None;
    }

    let collection = split_string(&album.unwrap());
    let albums = collection
      .iter()
      .enumerate()
      .filter_map(|(i, a)| map_album(i, a, tag));

    Some(albums.collect())
  }
}

fn map_album(i: usize, a: &String, tag: &Tag) -> Option<Album> {
  if i == 0 {
    let picture = tag.get_picture_type(PictureType::CoverFront);

    return Some(Album {
      title: Some(a.to_string()),
      artists: Artist::from_tag(tag),
      artwork: picture.map(|p| p.data().to_vec()),
    });
  }

  Some(Album::from(a))
}
