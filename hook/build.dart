import 'package:hooks/hooks.dart';
import 'package:native_toolchain_rust/native_toolchain_rust.dart';

Future<void> main(List<String> args) async => build(
  args,
  (BuildInput input, BuildOutputBuilder output) async {
    final builder = RustBuilder(
      cratePath: 'rust/',
      assetName: '${input.packageName}.dart',
    );

    await builder.run(input: input, output: output);
  },
);
