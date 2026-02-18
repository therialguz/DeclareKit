import UIKit

/// A node wrapper that applies a layout closure receiving both the built view and the build context.
///
/// Unlike `Modifier`, the closure receives `(view, context)` so it can reference
/// `context.parent` to add the view as a subview and set up constraints relative
/// to the parent. This eliminates intermediate wrapper views for layout operations.
@MainActor
public struct LayoutModifier<ModifiedNode: RepresentableNode>: RepresentableNode {
    private let node: ModifiedNode
    private let layout: (ModifiedNode.Representable, BuildContext) -> Void

    /// Creates a layout modifier wrapper around another node.
    ///
    /// - Parameters:
    ///   - node: The node being modified.
    ///   - layout: Closure that receives the built view and context, responsible for
    ///     adding the view to `context.parent` and setting up constraints.
    public init(
        _ node: ModifiedNode,
        _ layout: @escaping (ModifiedNode.Representable, BuildContext) -> Void
    ) {
        self.node = node
        self.layout = layout
    }

    /// Builds the wrapped node and applies the layout closure.
    public func build(in context: BuildContext) -> ModifiedNode.Representable {
        let view = node.build(in: context)
        layout(view, context)
        return view
    }
}
