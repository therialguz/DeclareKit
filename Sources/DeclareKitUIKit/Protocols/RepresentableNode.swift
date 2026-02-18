import UIKit

/// A declarative type that can be rendered into a `UIView`.
///
/// This is the base protocol for all view-level building blocks in DeclareKit.
/// Conforming types can produce either one view (`build`) or many (`buildList`).
@MainActor
public protocol RepresentableNode {
    /// The concrete view type produced by this node.
    associatedtype Representable: UIView

    /// Builds and returns a single view representation.
    func build(in context: BuildContext) -> Representable

    /// Builds and returns one or more views for tuple-like nodes.
    func buildList(in context: BuildContext) -> [UIView]
}

extension RepresentableNode {
    /// Default implementation wrapping `build(in:)` into a single-element array.
    public func buildList(in context: BuildContext) -> [UIView] {
        [build(in: context)]
    }

    /// Convenience: builds with an empty context (no parent).
    public func build() -> Representable {
        let context = BuildContext(parent: nil)
        return build(in: context)
    }
}
