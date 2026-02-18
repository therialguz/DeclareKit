import UIKit

/// Context passed through the node build tree.
///
/// Carries information about the parent view so that nodes can set up
/// layout constraints relative to their intended parent.
@MainActor
public struct BuildContext {
    /// The parent view that the built node will be added to, if known.
    public let parent: UIView?

    /// Inserts a child view into the parent.
    ///
    /// When `before` is non-nil, inserts the child immediately before that view.
    /// When `before` is nil, appends the child normally.
    public let insertChild: (UIView, _ before: UIView?) -> Void

    /// Creates a build context with an optional parent view and insertion strategy.
    ///
    /// - Parameters:
    ///   - parent: The parent view children will be added to.
    ///   - insertChild: Custom insertion closure. Defaults to `addSubview`, ignoring `before`.
    public init(parent: UIView? = nil, insertChild: ((UIView, UIView?) -> Void)? = nil) {
        self.parent = parent
        let p = parent
        self.insertChild = insertChild ?? { view, _ in p?.addSubview(view) }
    }
}
