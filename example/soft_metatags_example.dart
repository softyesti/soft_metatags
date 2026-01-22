// ignore_for_file: avoid_print

import 'dart:io';

import 'package:soft_metatags/soft_metatags.dart';

Future<void> main() async {
  await SoftMetatags.initialize(dir: Directory('../lib'));

  final result = await SoftMetatags.adder(100, 200);
  print('Call Rust and get: 100+200 = $result');
}
