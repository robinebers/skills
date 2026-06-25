# Skills

A small public repo of reusable agent skills, packaged for installation with [`npx skills`](https://skills.sh/).

## Included Skills

### Workflow

- `code-upgrade` - Engineering-discipline toolkit for non-technical users working with AI coders. Wraps KISS, DRY, YAGNI, fail-fast, and idempotency into commands. Includes:
  - **The Master Audit** - architecture map first, then duplicate / fail-fast / bloat / retry in either Normal (1 generalist sub-agent across the whole app) or Deep (3 specialist sub-agents in parallel, each running all 4 audits but scoped to a different part such as frontend / backend / other), returning one short executive plan.
  - **The Architecture Audit** - explain the app, then let the user grill it.
  - **The Plan Checklist** - vet a plan against KISS, YAGNI, DRY, fail-fast, and retry-safety before any code is written.
  - **The Bloat Audit** - find code AI coders tend to over-produce (dead code, one-shot helpers, defensive checks for impossible cases, etc.) and propose deletions.
  - **The Duplicate Audit** - find values and logic duplicated across the codebase, propose a single source of truth.
  - **The Fail-Fast Audit** - find places where errors are silently swallowed, propose loud failures.
  - **The Retry Audit** - find spots that could fire twice and cause real damage (duplicate emails, double charges), propose idempotency fixes.

- `worktree-setup` - Set up new AI agent workspaces (Git worktrees) so they start ready-to-go — same tools, same settings, same access as your main setup. No blank slate, no manual fiddling. Works with Cursor, Codex, Conductor, and Claude Code.

- `shepherd` - Shepherd a GitHub pull request to merge-ready by polling status, addressing automatic reviewer feedback (Cubic, Bugbot etc.), and verifying the review cycle is truly clean. Stops at merge-ready and never merges without explicit human approval.

- `hotseat` - Create significantly better plans by putting yourself into the hotseat. The agent challenges your plan one question at a time until everything's clear. Inspired by [Matt Pocock](https://github.com/mattpocock)'s [`grill-me`](https://github.com/mattpocock/skills/blob/main/grill-me/SKILL.md), but meaningfully improved for accuracy.

### macOS app development

Native macOS development with SwiftUI and AppKit — shell-first build/run/debug plus current design-system guidance (Liquid Glass, windowing, menus, AppKit interop).

- `macos-build-run-debug` - Build and debug macOS apps with shell-first Xcode/Swift workflows
- `macos-swiftui-patterns` - Build native macOS SwiftUI scenes, menus, settings, and windows
- `macos-liquid-glass` - Adopt modern macOS SwiftUI design and Liquid Glass
- `macos-window-management` - Customize SwiftUI window chrome, drag regions, behavior, and placement
- `macos-appkit-interop` - Bridge SwiftUI into AppKit for native macOS behavior
- `macos-view-refactor` - Refactor macOS SwiftUI views and scenes toward stable desktop structure
- `macos-telemetry` - Add lightweight Logger instrumentation and verify macOS runtime events
- `macos-test-triage` - Run and explain macOS test failures with focused reruns
- `macos-signing-entitlements` - Inspect codesign, entitlements, and Gatekeeper failures
- `macos-packaging-notarization` - Inspect packaging, signing, and notarization readiness
- `macos-swiftpm` - Build, run, and test macOS Swift packages

### iOS app development

SwiftUI and iOS workflows for Simulator-based development, debugging, and performance.

- `ios-app-intents` - Build and debug iOS App Intents integrations
- `ios-debugger-agent` - Debug iOS apps on Simulator
- `ios-simulator-browser` - Mirror an iOS Simulator into a browser with live SwiftUI previews
- `ios-ettrace-performance` - Profile symbolicated iOS simulator flows with ETTrace
- `ios-memgraph-leaks` - Capture and prove iOS simulator memory leaks
- `swiftui-liquid-glass` - Build SwiftUI Liquid Glass features
- `swiftui-ui-patterns` - Apply practical SwiftUI UI patterns
- `swiftui-performance-audit` - Audit SwiftUI runtime performance
- `swiftui-view-refactor` - Refactor large SwiftUI view files

### Expo / React Native

Building, shipping, and upgrading Expo apps.

- `building-native-ui` - Build Expo Router UI with native-feeling navigation, controls, media, and animation
- `native-data-fetching` - Implement and debug Expo network requests, caching, auth, offline, and Router data loaders
- `use-dom` - Use Expo DOM components to run web React code in native webviews
- `expo-dev-client` - Create and use Expo development clients when Expo Go is not enough
- `expo-api-routes` - Create Expo Router API routes for secrets, validation, webhooks, and proxies
- `expo-deployment` - Deploy Expo apps to TestFlight, App Store, Play Store, and EAS Hosting
- `expo-cicd-workflows` - Write and validate EAS workflow YAML files
- `expo-module` - Build Expo native modules and views with Swift, Kotlin, and config plugins
- `expo-tailwind-setup` - Set up Tailwind v4 / NativeWind v5 styling in Expo
- `expo-ui-swift-ui` - Use @expo/ui/swift-ui views inside Expo apps
- `expo-ui-jetpack-compose` - Use @expo/ui/jetpack-compose views inside Expo apps
- `upgrading-expo` - Upgrade Expo SDKs, fix dependencies, and migrate deprecated packages

### Stripe

- `stripe-best-practices` - Guide Stripe integration choices and implementation
- `upgrade-stripe` - Guide Stripe API and SDK upgrades

## Install

Install everything from GitHub:

```bash
npx skills add robinebers/skills
```

Install a single skill:

```bash
npx skills add robinebers/skills --skill code-upgrade
npx skills add robinebers/skills --skill worktree-setup
npx skills add robinebers/skills --skill macos-build-run-debug
npx skills add robinebers/skills --skill ios-debugger-agent
npx skills add robinebers/skills --skill expo-deployment
npx skills add robinebers/skills --skill stripe-best-practices
```

List what the package exposes:

```bash
npx skills add robinebers/skills --list
```

The `skills` CLI will install each skill into the right location for your agent, including Cursor, Claude Code, Codex, and others.

## Requirements for the app-dev skills

The macOS, iOS, Expo, and Stripe skills are agent-agnostic guidance; they assume the relevant local toolchains:

- **macOS / iOS** — Xcode and its command-line tools (`xcodebuild`, `swift`, `xcrun`, `codesign`, `leaks`, `log`).
- **iOS extras** — `ios-debugger-agent` works best with the [XcodeBuildMCP](https://github.com/cameroncooke/XcodeBuildMCP) server configured in your agent; `ios-simulator-browser` and the profiling skills use `npx` tools (`serve-sim`, `ettrace`).
- **Expo** — a Node/Expo project with the Expo CLI and EAS.
- **Stripe** — your own Stripe account and SDK.

## Credits

The macOS, iOS, Expo, and Stripe skills are adapted from OpenAI's [`openai/plugins`](https://github.com/openai/plugins) collection (MIT) and reworked to be agent-agnostic — Codex-specific run-button wiring (`.codex/environments/environment.toml`) and presentation metadata were removed, while the per-skill `agents/openai.yaml` interface files are kept so the skills still install cleanly into Codex via the `skills` CLI.
