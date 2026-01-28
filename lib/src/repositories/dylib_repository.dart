import 'dart:io';

import 'package:soft_metatags/src/services/dylib_service.dart';

/// Repository for handling the dynamic library lifecycle.
final class DylibRepository {
  /// Creates a new [DylibRepository].
  const DylibRepository(this._service);

  final DylibService _service;

  /// Whether the dynamic library is initialized.
  bool get initialized => _service.initialized;

  /// Initializes the dynamic library.
  Future<void> initialize([Directory? directory]) async {
    if (directory == null) return _service.init();
    return _service.initFromDir(directory);
  }

  /// Disposes the dynamic library.
  void dispose() => _service.dispose();
}
