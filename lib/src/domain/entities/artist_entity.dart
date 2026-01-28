import 'package:meta/meta.dart';
import 'package:soft_metatags/src/bindings/api/entities/artist.dart';

@immutable
/// Artist metadata.
final class ArtistMetaTag {
  /// Create a new [ArtistMetaTag].
  const ArtistMetaTag({
    this.name,
    this.picture,
  });

  /// Artist name.
  final String? name;

  /// Artist picture.
  final Uri? picture;

  @override
  int get hashCode => name.hashCode ^ picture.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtistMetaTag &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          picture == other.picture;
}

/// Extension methods for [ArtistMetaTag].
extension ArtistMetaTagExt on ArtistMetaTag {
  /// Create a new [ArtistMetaTag] from an [Artist].
  static ArtistMetaTag from(Artist artist) {
    final picture = artist.picture != null
        ? Uri.dataFromBytes(artist.picture!)
        : null;

    return ArtistMetaTag(
      picture: picture,
      name: artist.name,
    );
  }
}
