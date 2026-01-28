import 'dart:io';

import 'package:meta/meta.dart';
import 'package:soft_metatags/src/bindings/api/entities/song.dart';
import 'package:soft_metatags/src/domain/entities/album_entity.dart';
import 'package:soft_metatags/src/domain/entities/artist_entity.dart';
import 'package:soft_metatags/src/domain/entities/disc_entity.dart';
import 'package:soft_metatags/src/domain/entities/genre_entity.dart';
import 'package:soft_metatags/src/domain/entities/track_entity.dart';

@immutable
/// Song metadata.
final class SongMetaTag {
  /// Creates a new [SongMetaTag].
  const SongMetaTag({
    required this.file,
    required this.title,
    required this.duration,
    this.bpm,
    this.year,
    this.date,
    this.disc,
    this.track,
    this.isrc,
    this.mood,
    this.label,
    this.lyrics,
    this.albums,
    this.genres,
    this.comment,
    this.barcode,
    this.artists,
    this.composer,
    this.lyricist,
    this.performer,
    this.conductor,
    this.copyright,
    this.encodedBy,
    this.catalogNumber,
  });

  /// File.
  final File file;

  /// Title.
  final String title;

  /// Duration.
  final Duration duration;

  /// Beats per minute.
  final int? bpm;

  /// Year.
  final int? year;

  /// International Standard Recording Code.
  final String? isrc;

  /// Mood.
  final String? mood;

  /// Label.
  final String? label;

  /// Date.
  final DateTime? date;

  /// Lyrics.
  final String? lyrics;

  /// Comment.
  final String? comment;

  /// Barcode.
  final String? barcode;

  /// Composer.
  final String? composer;

  /// Lyricist.
  final String? lyricist;

  /// Performer.
  final String? performer;

  /// Disc.
  final DiscMetaTag? disc;

  /// Conductor.
  final String? conductor;

  /// Copyright.
  final String? copyright;

  /// Encoded by.
  final String? encodedBy;

  /// Catalog number.
  final int? catalogNumber;

  /// Track.
  final TrackMetaTag? track;

  /// Albums.
  final List<AlbumMetaTag>? albums;

  /// Genres.
  final List<GenreMetaTag>? genres;

  /// Artists.
  final List<ArtistMetaTag>? artists;

  /// Returns the first album in the list.
  AlbumMetaTag? get mainAlbum => albums?.firstOrNull;

  /// Returns the first genre in the list.
  GenreMetaTag? get mainGenre => genres?.firstOrNull;

  /// Returns the first artist in the list.
  ArtistMetaTag? get mainArtist => artists?.firstOrNull;

  @override
  int get hashCode =>
      bpm.hashCode ^
      file.hashCode ^
      year.hashCode ^
      date.hashCode ^
      disc.hashCode ^
      isrc.hashCode ^
      mood.hashCode ^
      track.hashCode ^
      title.hashCode ^
      label.hashCode ^
      lyrics.hashCode ^
      albums.hashCode ^
      genres.hashCode ^
      barcode.hashCode ^
      comment.hashCode ^
      artists.hashCode ^
      duration.hashCode ^
      composer.hashCode ^
      lyricist.hashCode ^
      performer.hashCode ^
      conductor.hashCode ^
      copyright.hashCode ^
      encodedBy.hashCode ^
      catalogNumber.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongMetaTag &&
          runtimeType == other.runtimeType &&
          bpm == other.bpm &&
          file == other.file &&
          year == other.year &&
          date == other.date &&
          disc == other.disc &&
          isrc == other.isrc &&
          mood == other.mood &&
          track == other.track &&
          title == other.title &&
          label == other.label &&
          lyrics == other.lyrics &&
          albums == other.albums &&
          genres == other.genres &&
          comment == other.comment &&
          artists == other.artists &&
          barcode == other.barcode &&
          duration == other.duration &&
          composer == other.composer &&
          lyricist == other.lyricist &&
          performer == other.performer &&
          conductor == other.conductor &&
          copyright == other.copyright &&
          encodedBy == other.encodedBy &&
          catalogNumber == other.catalogNumber;
}

/// Extension methods for [SongMetaTag].
extension SongMetaTagExt on SongMetaTag {
  /// Create a new [SongMetaTag] from an [Song].
  static SongMetaTag from(Song song) {
    final date = song.meta?.date != null
        ? DateTime.fromMillisecondsSinceEpoch(song.meta!.date!)
        : null;

    return SongMetaTag(
      date: date,
      bpm: song.meta?.bpm,
      file: File(song.path),
      year: song.meta?.year,
      isrc: song.meta?.isrc,
      mood: song.meta?.mood,
      label: song.meta?.label,
      lyrics: song.meta?.lyrics,
      comment: song.meta?.comment,
      barcode: song.meta?.barcode,
      composer: song.meta?.composer,
      lyricist: song.meta?.lyricist,
      performer: song.meta?.performer,
      conductor: song.meta?.conductor,
      copyright: song.meta?.copyright,
      encodedBy: song.meta?.encodedBy,
      title: song.meta?.title ?? song.title,
      catalogNumber: song.meta?.catalogNumber,
      disc: DiscMetaTagExt.from(song.meta?.disc),
      track: TrackMetaTagExt.from(song.meta?.track),
      duration: Duration(seconds: song.duration.toInt()),
      albums: song.meta?.albums?.map(AlbumMetaTagExt.from).toList(),
      genres: song.meta?.genres?.map(GenreMetaTagExt.from).toList(),
      artists: song.meta?.artists?.map(ArtistMetaTagExt.from).toList(),
    );
  }
}
