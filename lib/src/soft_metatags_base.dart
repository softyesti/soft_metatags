import 'dart:io';

import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:path/path.dart' as p;
import 'package:soft_metatags/src/rust/api/soft_metatags.dart';
import 'package:soft_metatags/src/rust/frb_generated.dart';

///
abstract class SoftMetatags {
  /// Initializes the Rust library.
  static Future<void> initialize({Directory? dir}) async {
    if (dir == null) return RustLib.init();

    final filename = p.setExtension('libsoft_metatags', _getExtension());
    final path = p.normalize(p.join(dir.path.trim(), filename.trim()));

    return RustLib.init(externalLibrary: ExternalLibrary.open(path));
  }

  /// Disposes the Rust library.
  static void dispose() => RustLib.dispose();

  /// A minimal adder function that adds two integers.
  static Future<int> adder(int a, int b) => minimalAdder(a: a, b: b);

  static String _getExtension() {
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
