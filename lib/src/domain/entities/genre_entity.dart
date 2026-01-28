import 'package:meta/meta.dart';
import 'package:soft_metatags/src/bindings/api/entities/genre.dart';

@immutable
/// Genre metadata.
final class GenreMetaTag {
  /// Create a new [GenreMetaTag].
  const GenreMetaTag({
    this.name,
  });

  /// Genre name.
  final String? name;

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenreMetaTag &&
          runtimeType == other.runtimeType &&
          name == other.name;
}

/// Extension methods for [GenreMetaTag].
extension GenreMetaTagExt on GenreMetaTag {
  /// Create a new [GenreMetaTag] from an [Genre].
  static GenreMetaTag from(Genre genre) {
    return GenreMetaTag(name: genre.name);
  }
}
