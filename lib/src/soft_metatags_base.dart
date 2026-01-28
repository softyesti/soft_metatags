import 'dart:io';

import 'package:soft_metatags/src/domain/entities/song_entity.dart';
import 'package:soft_metatags/src/exceptions/initialized_exception.dart';
import 'package:soft_metatags/src/repositories/api_repository.dart';
import 'package:soft_metatags/src/repositories/dylib_repository.dart';
import 'package:soft_metatags/src/services/api_service.dart';
import 'package:soft_metatags/src/services/dylib_service.dart';

/// [SoftMetaTags] library.
final class SoftMetaTags {
  const SoftMetaTags._(this._apiRepo, this._dylibRepo);

  final ApiRepository _apiRepo;
  final DylibRepository _dylibRepo;

  static SoftMetaTags? _instance;

  /// Gets the instance of the [SoftMetaTags] library.
  static SoftMetaTags get instance {
    if (_instance != null) return _instance!;
    throw SoftMetaTagsInitException();
  }

  /// Initializes the [SoftMetaTags] library.
  static Future<void> initialize([Directory? directory]) async {
    if (_instance?._dylibRepo.initialized ?? false) {
      return;
    }

    _instance = const SoftMetaTags._(
      ApiRepository(ApiService()),
      DylibRepository(DylibService()),
    );

    return _instance!._dylibRepo.initialize(directory);
  }

  /// Disposes the [SoftMetaTags] library.
  static void dispose() {
    _instance?._dylibRepo.dispose();
    _instance = null;
  }

  /// Read audio metadata from a [File].
  Future<SongMetaTag?> read(File file) async => _apiRepo.read(file);

  /// Read audio metadata from a [List] of [File].
  Future<Iterable<SongMetaTag>> readAll(List<File> files) async {
    final songs = await Future.wait(files.map(_apiRepo.read));
    return songs.nonNulls;
  }
}
