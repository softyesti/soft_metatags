.PHONY: bindings clean upgrade

bindings:
	@echo "Generating bindings..."
	@flutter_rust_bridge_codegen generate
	@cd rust/ && cargo build --release

clean:
	@echo "Cleaning project..."
	@fvm flutter clean
	@rm -rf rust/target/

upgrade:
	@echo "Upgrading dependencies..."
	@make clean
	@fvm flutter pub get
	@fvm flutter pub upgrade
	@fvm flutter pub upgrade --major-versions
