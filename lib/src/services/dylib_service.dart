import 'dart:io';

import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:path/path.dart' as p;
import 'package:soft_metatags/src/bindings/frb_generated.dart';

/// Service for handling the dynamic library lifecycle.
final class DylibService {
  /// Creates a new [DylibService].
  const DylibService();

  /// Get the name of the dynamic library.
  String get _name => 'libsoft_metatags';

  /// Get the extension of the dynamic library.
  String get _extension => _getExtension();

  /// Get the filename of the dynamic library.
  String get _filename => p.setExtension(_name, _extension);

  /// Whether the dynamic library is initialized.
  bool get initialized => RustLib.instance.initialized;

  /// Initialize the dynamic library.
  Future<void> init() => RustLib.init();

  /// Initialize the dynamic library from a directory.
  Future<void> initFromDir(Directory directory) {
    final path = p.join(directory.path, _filename);
    return RustLib.init(externalLibrary: ExternalLibrary.open(path));
  }

  /// Dispose the dynamic library.
  void dispose() => RustLib.dispose();

  String _getExtension() {
    if (Platform.isWindows) {
      return '.dll';
    } else if (Platform.isIOS || Platform.isMacOS) {
      return '.dylib';
    } else if (Platform.isLinux || Platform.isAndroid) {
      return '.so';
    }

    return '';
  }
}
