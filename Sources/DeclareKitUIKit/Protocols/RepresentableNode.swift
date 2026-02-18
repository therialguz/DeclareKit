import UIKit

/// A declarative type that can be rendered into a `UIView`.
///
/// This is the base protocol for all view-level building blocks in DeclareKit.
/// Conforming types can produce either one view (`build`) or many (`buildList`).
@MainActor
public protocol RepresentableNode {
    associatedtype Representable: UIView = UIView
    /// Builds and returns a single view representation.
    func build(in context: BuildContext)
}

extension RepresentableNode {
    /// Convenience: builds with an empty context (no parent).
    public func build() {
        let context = BuildContext(parent: nil)
        build(in: context)
    }
}
