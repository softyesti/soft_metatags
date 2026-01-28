import 'package:soft_metatags/src/exceptions/generic_exception.dart';
import 'package:soft_metatags/src/soft_metatags_base.dart';

/// Exception thrown when the [SoftMetaTags] library is not initialized.
final class SoftMetaTagsInitException extends SoftMetaTagsException {
  @override
  String toString() =>
      // ignore: lines_longer_than_80_chars
      '[SoftMetaTags] is not initialized. Please call SoftMetaTags.initialize() first.';
}
