import 'package:meta/meta.dart';
import 'package:soft_metatags/src/bindings/api/entities/disc.dart';

@immutable
/// Disc metadata.
final class DiscMetaTag {
  /// Create a new [DiscMetaTag].
  const DiscMetaTag({
    this.total,
    this.number,
  });

  /// Total number of discs.
  final int? total;

  /// Current disc number.
  final int? number;

  @override
  int get hashCode => total.hashCode ^ number.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiscMetaTag &&
          runtimeType == other.runtimeType &&
          total == other.total &&
          number == other.number;
}

/// Extension methods for [DiscMetaTag].
extension DiscMetaTagExt on DiscMetaTag {
  /// Create a new [DiscMetaTag] from an [Disc].
  static DiscMetaTag? from(Disc? disc) {
    if (disc == null) return null;

    return DiscMetaTag(
      total: disc.total,
      number: disc.number,
    );
  }
}
