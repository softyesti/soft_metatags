import 'dart:io';

import 'package:soft_metatags/src/domain/entities/song_entity.dart';
import 'package:soft_metatags/src/services/api_service.dart';

/// Repository for handling the dynamic library functions.
final class ApiRepository {
  /// Creates a new [ApiRepository].
  const ApiRepository(this._service);

  final ApiService _service;

  /// Read audio metadata from a [File].
  Future<SongMetaTag?> read(File file) async {
    final song = await _service.read(file.path);
    if (song == null) return null;

    return SongMetaTagExt.from(song);
  }
}
