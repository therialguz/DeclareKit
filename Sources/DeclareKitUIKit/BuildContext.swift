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
    public let insertChild: (_ child: UIView, _ before: UIView?) -> Void

    /// Creates a build context with an optional parent view and insertion strategy.
    ///
    /// - Parameters:
    ///   - parent: The parent view children will be added to.
    ///   - insertChild: Custom insertion closure. Defaults to `addSubview`, ignoring `before`.
    public init(parent: UIView? = nil, insertChild: ((_ child: UIView, _ before: UIView?) -> Void)? = nil) {
        self.parent = parent
        let p = parent
        self.insertChild = insertChild ?? { view, _ in p?.addSubview(view) }
    }

    /// Returns a new context that intercepts each inserted view, passing it to
    /// `wrapping` before forwarding to the original `insertChild`.
    ///
    /// Used by `Modifier` to observe the view a node mounts without changing
    /// where or how it gets inserted.
    public func intercepting(_ wrapping: @escaping (_ child: UIView) -> Void) -> BuildContext {
        BuildContext(parent: parent) { child, before in
            wrapping(child)
            self.insertChild(child, before)
        }
    }

    /// Builds a node using a temporary context, inserts the produced views before
    /// `anchor` (or appended if nil), and returns those views for later reuse.
    ///
    /// Used by `Show` and `ForEach` to hold references to views they may need to
    /// remove and re-insert across condition or data changes.
    public func capture(before anchor: UIView? = nil, _ build: (BuildContext) -> Void) -> [UIView] {
        var captured: [UIView] = []
        let captureContext = BuildContext(parent: parent) { view, _ in
            captured.append(view)
            self.insertChild(view, anchor)
        }
        build(captureContext)
        return captured
    }
}
