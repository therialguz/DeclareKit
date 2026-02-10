import UIKit
import DeclareKitCore

/// A node wrapper that applies a mutation closure to the built view.
///
/// Modifier closures are reactive by default and re-run when observed signals change.
public struct Modifier<ModifiedNode: RepresentableNode>: RepresentableNode {
    private let node: ModifiedNode
    private let modifier: (ModifiedNode.Representable) -> Void
    private let reactive: Bool

    /// Creates a modifier wrapper around another node.
    ///
    /// - Parameters:
    ///   - node: The node being modified.
    ///   - reactive: Whether to re-apply the modifier reactively.
    ///   - modifier: Mutation closure applied to the built view.
    public init(
        _ node: ModifiedNode,
        reactive: Bool = true,
        _ modifier: @escaping (ModifiedNode.Representable) -> Void
    ) {
        self.node = node
        self.reactive = reactive
        self.modifier = modifier
    }

    /// Builds the wrapped node and applies the modifier closure.
    public func build() -> ModifiedNode.Representable {
        let view = node.build()
        if reactive {
            createEffect { [weak view] in
                guard let view else { return }
                if let animation = AnimationContext.current {
                    animation.perform {
                        self.modifier(view)
                    }
                } else {
                    self.modifier(view)
                }
            }
        } else {
            modifier(view)
        }
        return view
    }
}
