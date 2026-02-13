import UIKit

/// Wraps content and centers it within a container view.
///
/// When centering on a single axis, the other axis pins the child
/// to both edges so it fills the available space.
public struct CenteredInSuperview<Content: RepresentableNode>: RepresentableNode {
    private let content: Content
    private let axis: NSLayoutConstraint.Axis?

    init(_ content: Content, axis: NSLayoutConstraint.Axis? = nil) {
        self.content = content
        self.axis = axis
    }

    public func build(in context: BuildContext) -> UIView {
        let container = UIView()
        let childContext = BuildContext(parent: container)
        let child = content.build(in: childContext)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(child)

        var constraints: [NSLayoutConstraint] = []

        let centerH = axis == nil || axis == .horizontal
        let centerV = axis == nil || axis == .vertical

        // --- Horizontal ---
        if centerH {
            constraints.append(
                child.centerXAnchor.constraint(equalTo: container.centerXAnchor))
            constraints.append(
                child.leadingAnchor.constraint(
                    greaterThanOrEqualTo: container.leadingAnchor))
            constraints.append(
                child.trailingAnchor.constraint(
                    lessThanOrEqualTo: container.trailingAnchor))
        } else {
            constraints.append(
                child.leadingAnchor.constraint(equalTo: container.leadingAnchor))
            constraints.append(
                child.trailingAnchor.constraint(equalTo: container.trailingAnchor))
        }

        // --- Vertical ---
        if centerV {
            constraints.append(
                child.centerYAnchor.constraint(equalTo: container.centerYAnchor))
            constraints.append(
                child.topAnchor.constraint(
                    greaterThanOrEqualTo: container.topAnchor))
            constraints.append(
                child.bottomAnchor.constraint(
                    lessThanOrEqualTo: container.bottomAnchor))
        } else {
            constraints.append(
                child.topAnchor.constraint(equalTo: container.topAnchor))
            constraints.append(
                child.bottomAnchor.constraint(equalTo: container.bottomAnchor))
        }

        NSLayoutConstraint.activate(constraints)
        return container
    }
}

// MARK: - RepresentableNode extensions

extension RepresentableNode {
    /// Centers the view in its superview on both axes.
    public func centerInSuperview() -> CenteredInSuperview<Self> {
        CenteredInSuperview(self)
    }

    /// Centers the view in its superview on the given axis.
    ///
    /// The non-centered axis pins to both edges (fills available space).
    public func centerInSuperview(
        axis: NSLayoutConstraint.Axis
    ) -> CenteredInSuperview<Self> {
        CenteredInSuperview(self, axis: axis)
    }
}
