import 'package:meta/meta.dart';
import 'package:soft_metatags/src/bindings/api/entities/album.dart';
import 'package:soft_metatags/src/domain/entities/artist_entity.dart';

@immutable
/// Album metadata.
final class AlbumMetaTag {
  /// Create a new [AlbumMetaTag].
  const AlbumMetaTag({
    this.title,
    this.artwork,
    this.artists,
  });

  /// Album title.
  final String? title;

  /// Album artwork.
  final Uri? artwork;

  /// Album artists.
  final List<ArtistMetaTag>? artists;

  /// Returns the first artist in the list.
  ArtistMetaTag? get mainArtist => artists?.firstOrNull;

  @override
  int get hashCode => title.hashCode ^ artwork.hashCode ^ artists.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumMetaTag &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          artwork == other.artwork &&
          artists == other.artists;
}

/// Extension methods for [AlbumMetaTag].
extension AlbumMetaTagExt on AlbumMetaTag {
  /// Create a new [AlbumMetaTag] from an [Album].
  static AlbumMetaTag from(Album album) {
    final artwork = album.artwork != null
        ? Uri.dataFromBytes(album.artwork!)
        : null;

    return AlbumMetaTag(
      artwork: artwork,
      title: album.title,
      artists: album.artists?.map(ArtistMetaTagExt.from).toList(),
    );
  }
}
