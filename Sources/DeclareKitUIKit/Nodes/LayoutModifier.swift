import UIKit

/// A node wrapper that sets up layout constraints after the view is mounted.
///
/// Unlike `Modifier`, the closure runs after `insertChild` so the view already
/// has a superview when constraints are activated.
@MainActor
public struct LayoutModifier<ModifiedNode: RepresentableNode>: RepresentableNode {
    public typealias Representable = ModifiedNode.Representable
    private let node: ModifiedNode
    private let layout: (Representable) -> Void

    /// Creates a layout modifier wrapper around another node.
    ///
    /// - Parameters:
    ///   - node: The node being modified.
    ///   - layout: Closure that receives the mounted view and sets up constraints.
    ///     The view already has a `superview` when this closure runs.
    public init(
        _ node: ModifiedNode,
        _ layout: @escaping (Representable) -> Void
    ) {
        self.node = node
        self.layout = layout
    }

    /// Builds the wrapped node, mounts it, then applies the layout closure.
    public func build(in context: BuildContext) {
        let layoutContext = BuildContext(parent: context.parent) { view, before in
            context.insertChild(view, before)
            guard let typed = view as? ModifiedNode.Representable else { return }
            self.layout(typed)
        }
        node.build(in: layoutContext)
    }
}
