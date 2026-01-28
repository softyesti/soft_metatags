import 'package:meta/meta.dart';
import 'package:soft_metatags/src/bindings/api/entities/track.dart';

@immutable
/// Track metadata.
final class TrackMetaTag {
  /// Create a new [TrackMetaTag].
  const TrackMetaTag({
    this.total,
    this.number,
  });

  /// Total number of tracks.
  final int? total;

  /// Current track number.
  final int? number;

  @override
  int get hashCode => total.hashCode ^ number.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackMetaTag &&
          runtimeType == other.runtimeType &&
          total == other.total &&
          number == other.number;
}

/// Extension methods for [TrackMetaTag].
extension TrackMetaTagExt on TrackMetaTag {
  /// Create a new [TrackMetaTag] from an [Track].
  static TrackMetaTag? from(Track? track) {
    if (track == null) return null;

    return TrackMetaTag(
      total: track.total,
      number: track.number,
    );
  }
}
