# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Test Commands

```bash
swift build          # Build the package
swift test           # Run all tests
swift test --filter DeclareKitTests.example  # Run a single test
```

Requires Swift 6.2+ toolchain. Targets iOS 26+ and macOS 26+.

## Architecture

DeclareKit is a **declarative UIKit wrapper** — a SwiftUI-inspired DSL that produces UIKit view hierarchies instead of SwiftUI views. The core abstraction is the `RepresentableNode` protocol (analogous to SwiftUI's `View`).

### Core Protocol: `RepresentableNode`

- `build(in: BuildContext) -> Representable` — materializes a `UIView` subclass
- `buildList(in:) -> [UIView]` — returns multiple views (used by containers like `Stack`)
- `preview() -> HostViewController` — wraps a node for Xcode `#Preview` usage

### Result Builder: `@NodeBuilder`

A `@resultBuilder` that enables SwiftUI-like syntax. Supports:
- Single/multiple child expressions via parameter packs (`_TupleNode<each Child>`)
- Conditional content (`_ConditionalNode` via `buildEither`)
- Optional content (`buildIf`)
- String literals auto-wrapped as `Text` nodes

### Key Types

| Type | Role |
|------|------|
| `Text` | Wraps `UILabel` |
| `Button` | Wraps `UIButton` with action closure |
| `Stack` | Wraps `UIStackView`, takes axis/spacing/alignment |
| `Padding` | Adds inset constraints around child |
| `Group` | Flattens children (transparent container) |
| `NavigationController` | Embeds content in `UINavigationController` with proper VC containment |
| `Modifier<Node>` | Applies a closure to the built `UIView`, preserving the `Representable` associated type |
| `_TupleNode` | Internal: holds multiple heterogeneous children via parameter packs |
| `_ConditionalNode` | Internal: holds if/else branch content |
| `EmptyView` | Placeholder for empty `@NodeBuilder` blocks |

### Modifier Pattern

Modifiers chain by wrapping nodes in `Modifier<Node>` structs. Type-constrained extensions (e.g., `where Representable == UILabel`) add type-safe modifiers for specific UIView subclasses.

### `BuildContext`

Passed through `build(in:)` calls. Carries the `parentViewController` — needed for proper UIKit view controller containment (e.g., `NavigationController`).

### `HostViewController`

Root view controller that takes any `RepresentableNode`, calls `build(in:)`, and pins the result to safe area edges. Used as the entry point and for `#Preview`.
