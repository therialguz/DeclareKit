import UIKit

struct Modifier<ModifiedNode: RepresentableNode>: RepresentableNode {
    private let node: ModifiedNode
    private let modifier: (ModifiedNode.Representable) -> Void

    init(
        _ node: ModifiedNode,
        _ modifier: @escaping (ModifiedNode.Representable) -> Void
    ) {
        self.node = node
        self.modifier = modifier
    }

    func build() -> ModifiedNode.Representable {
        let view = node.build()
        modifier(view)
        return view
    }
}
