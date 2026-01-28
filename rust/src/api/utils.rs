use flutter_rust_bridge::frb;

#[frb(ignore)]
pub fn split_string(string: &String) -> Vec<String> {
  string.split(";").map(|s| s.to_string()).collect()
}

#[frb(ignore)]
pub fn extract_filename(string: &String) -> String {
  let path = std::path::Path::new(string);
  path.file_prefix().unwrap().to_str().unwrap().to_string()
}
