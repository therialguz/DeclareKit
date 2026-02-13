import UIKit

/// Context passed through the node build tree.
///
/// Carries information about the parent view so that nodes can set up
/// layout constraints relative to their intended parent.
@MainActor
public struct BuildContext {
    /// The parent view that the built node will be added to, if known.
    public let parent: UIView?

    /// Creates a build context with an optional parent view.
    public init(parent: UIView? = nil) {
        self.parent = parent
    }
}
