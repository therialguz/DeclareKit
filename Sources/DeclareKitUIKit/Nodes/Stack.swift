import UIKit

/// A declarative wrapper around `UIStackView`.
public struct Stack<Content: RepresentableNode>: RepresentableNode {
    private let axis: NSLayoutConstraint.Axis
    private let spacing: CGFloat
    private let alignment: UIStackView.Alignment

    private let content: Content

    /// Creates a stack with axis, spacing, alignment, and arranged content.
    public init(
        _ axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0,
        alignment: UIStackView.Alignment = .fill, @NodeBuilder _ content: () -> Content
    ) {
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment

        self.content = content()
    }

    /// Builds the configured `UIStackView`.
    public func build() -> UIStackView {
        let children = content.buildList()
        let stack = UIStackView(arrangedSubviews: children)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = axis
        stack.spacing = spacing
        stack.alignment = alignment
        stack.distribution = .equalSpacing

        return stack
    }
}
