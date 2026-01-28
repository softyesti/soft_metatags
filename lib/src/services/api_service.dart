import 'dart:io';

import 'package:soft_metatags/src/bindings/api/entities/song.dart';
import 'package:soft_metatags/src/bindings/api/soft_metatags.dart' as api;

/// Service for handling the dynamic library functions.
final class ApiService {
  /// Creates a new [ApiService].
  const ApiService();

  /// Read audio metadata from a [File].
  Future<Song?> read(String path) async => api.read(path: path);
}
