import UIKit

/// A declarative wrapper around `UIStackView`.
public struct Stack<Content: RepresentableNode>: RepresentableNode {
    public typealias Representable = UIStackView
    
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
    public func build(in context: BuildContext) {
        let stack = UIStackView()
        context.insertChild(stack, nil)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = axis
        stack.spacing = spacing
        stack.alignment = alignment
        stack.distribution = .equalSpacing

        let stackContext = BuildContext(parent: stack) { [weak stack] view, before in
            guard let stack else { return }
            if let before, let index = stack.arrangedSubviews.firstIndex(of: before) {
                stack.insertArrangedSubview(view, at: index)
            } else {
                stack.addArrangedSubview(view)
            }
        }
        
        content.build(in: stackContext)
    }
}
