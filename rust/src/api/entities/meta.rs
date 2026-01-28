use crate::api::entities::{
  album::Album, artist::Artist, disc::Disc, genre::Genre, track::Track,
};
use flutter_rust_bridge::frb;
use lofty::tag::{ItemKey, Tag};

#[frb(dart_metadata=("immutable" import "package:meta/meta.dart"))]
pub struct Meta {
  pub bpm: Option<u32>,
  pub year: Option<u32>,
  pub date: Option<u32>,
  pub disc: Option<Disc>,
  pub track: Option<Track>,
  pub isrc: Option<String>,
  pub mood: Option<String>,
  pub title: Option<String>,
  pub label: Option<String>,
  pub lyrics: Option<String>,
  pub comment: Option<String>,
  pub barcode: Option<String>,
  pub composer: Option<String>,
  pub lyricist: Option<String>,
  pub performer: Option<String>,
  pub conductor: Option<String>,
  pub copyright: Option<String>,
  pub albums: Option<Vec<Album>>,
  pub genres: Option<Vec<Genre>>,
  pub encoded_by: Option<String>,
  pub catalog_number: Option<u32>,
  pub artists: Option<Vec<Artist>>,
}

macro_rules! extract_str {
  ($tag:expr, $key:expr) => {
    $tag.get_string($key).map(|s| s.to_string())
  };
}

macro_rules! extract_num {
  ($tag:expr, $key:expr) => {
    $tag.get_string($key).and_then(|s| s.parse::<u32>().ok())
  };

  ($tag:expr, $key1:expr, $key2:expr) => {
    $tag
      .get_string($key1)
      .or_else(|| $tag.get_string($key2))
      .and_then(|s| s.parse::<u32>().ok())
  };
}

impl Meta {
  #[frb(ignore)]
  pub fn from_tag(tag: &Tag) -> Meta {
    Meta {
      date: None,
      disc: Disc::from_tag(tag),
      track: Track::from_tag(tag),
      albums: Album::from_tag(tag),
      genres: Genre::from_tag(tag),
      artists: Artist::from_tag(tag),
      year: extract_num!(tag, &ItemKey::Year),
      mood: extract_str!(tag, &ItemKey::Mood),
      isrc: extract_str!(tag, &ItemKey::Isrc),
      label: extract_str!(tag, &ItemKey::Label),
      lyrics: extract_str!(tag, &ItemKey::Lyrics),
      barcode: extract_str!(tag, &ItemKey::Barcode),
      comment: extract_str!(tag, &ItemKey::Comment),
      title: extract_str!(tag, &ItemKey::TrackTitle),
      lyricist: extract_str!(tag, &ItemKey::Lyricist),
      composer: extract_str!(tag, &ItemKey::Composer),
      performer: extract_str!(tag, &ItemKey::Performer),
      conductor: extract_str!(tag, &ItemKey::Conductor),
      encoded_by: extract_str!(tag, &ItemKey::EncodedBy),
      copyright: extract_str!(tag, &ItemKey::CopyrightMessage),
      catalog_number: extract_num!(tag, &ItemKey::CatalogNumber),
      bpm: extract_num!(tag, &ItemKey::Bpm, &ItemKey::IntegerBpm),
    }
  }
}
