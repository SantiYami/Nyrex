# AI Dependency Lookup strategy (MCP equivalent)

When an AI agent (you) is requested to investigate, query, or add libraries from `crates.io` (Rust) or `pub.dev` (Flutter), do NOT assume there is a local MCP server configured with these specific endpoints out of the box.

Instead, perform lookups directly through your native Terminal tool integrations (`run_command` via powershell):

## For Cargo (Rust) Packages

- **Command:** `cargo search <crate>`
- Always check the latest stable minor bounds and include them directly within `Cargo.toml`.
- To review dependencies natively, use `cargo tree` or `cargo info <crate>`.

## For pub.dev (Flutter/Dart) Packages

- **Command:** `flutter pub search <package_name>`
- This will query the pub.dev backend and return matching packages and their versions to standard output.
- To add a package to a Flutter project, use `flutter pub add <package>` inside `apps/flutter` to automatically resolve and insert the exact latest secure version into `pubspec.yaml` without guessing.

*Fallback Strategy:* If precise API documentation is needed, instruct your `browser_subagent` to navigate to `https://docs.rs/<crate>` or `https://pub.dev/packages/<package>` directly to retrieve implementation snippets.
