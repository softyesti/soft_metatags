.PHONY: runner bindings clean upgrade

runner:
	@echo "Running the build_runner..."
	@fvm dart run build_runner build -d

bindings:
	@echo "Generating bindings..."
	@make clean
	@flutter_rust_bridge_codegen generate
	@cd rust/ && cargo build --release

clean:
	@echo "Cleaning project..."
	@fvm flutter clean
	@rm -rf rust/target/
	@rm -rf lib/src/bindings/
	@fvm dart pub get

upgrade:
	@echo "Upgrading dependencies..."
	@make clean
	@fvm dart pub get
	@fvm dart pub upgrade
	@fvm dart pub upgrade --major-versions
