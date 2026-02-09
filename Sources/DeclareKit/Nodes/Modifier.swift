import UIKit

struct Modifier<ModifiedNode: RepresentableNode>: RepresentableNode {
    private let node: ModifiedNode
    private let modifier: (ModifiedNode.Representable) -> Void
    private let reactive: Bool

    init(
        _ node: ModifiedNode,
        reactive: Bool = true,
        _ modifier: @escaping (ModifiedNode.Representable) -> Void
    ) {
        self.node = node
        self.reactive = reactive
        self.modifier = modifier
    }

    func build() -> ModifiedNode.Representable {
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
