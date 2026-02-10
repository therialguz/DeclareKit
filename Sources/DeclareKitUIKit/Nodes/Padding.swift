import UIKit

/// Wraps content and applies edge insets around it.
public struct Padding<NodeContent: RepresentableNode>: RepresentableNode {
    private let insets: UIEdgeInsets
    private let content: NodeContent

    /// Creates padded content with uniform insets on all edges.
    public init(_ padding: CGFloat, @NodeBuilder _ content: () -> NodeContent) {
        self.insets = .init(top: padding, left: padding, bottom: padding, right: padding)
        self.content = content()
    }

    /// Creates padded content with explicit edge insets.
    public init(insets: UIEdgeInsets, @NodeBuilder _ content: () -> NodeContent) {
        self.insets = insets
        self.content = content()
    }

    /// Builds a container view constrained to the padded child content.
    public func build() -> UIView {
        let child = content.build()
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(child)

        NSLayoutConstraint.activate([
            child.topAnchor.constraint(equalTo: container.topAnchor, constant: insets.top),
            child.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: insets.left),
            child.trailingAnchor.constraint(
                equalTo: container.trailingAnchor, constant: -insets.right),
            child.bottomAnchor.constraint(
                equalTo: container.bottomAnchor, constant: -insets.bottom),
        ])

        return container
    }
}
