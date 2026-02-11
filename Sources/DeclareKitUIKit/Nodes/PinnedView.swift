import UIKit

/// Wraps content and pins it to its container's edges or a layout guide.
///
/// When only a subset of edges is specified, the unconstrained axis
/// centers the child and adds inequality constraints to prevent overflow.
public struct PinnedView<Content: RepresentableNode>: RepresentableNode {
    private let content: Content
    private let guide: LayoutGuideReference?
    private let edges: LayoutEdge
    private let insets: UIEdgeInsets

    init(
        _ content: Content,
        guide: LayoutGuideReference? = nil,
        edges: LayoutEdge = .all,
        insets: UIEdgeInsets = .zero
    ) {
        self.content = content
        self.guide = guide
        self.edges = edges
        self.insets = insets
    }

    public func build() -> UIView {
        let child = content.build()
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(child)

        // Resolve anchor source: layout guide or container itself.
        let topTarget: NSLayoutYAxisAnchor
        let bottomTarget: NSLayoutYAxisAnchor
        let leadingTarget: NSLayoutXAxisAnchor
        let trailingTarget: NSLayoutXAxisAnchor
        let centerXTarget: NSLayoutXAxisAnchor
        let centerYTarget: NSLayoutYAxisAnchor

        if let guide {
            let lg: UILayoutGuide = switch guide {
            case .safeAreaLayoutGuide:  container.safeAreaLayoutGuide
            case .layoutMarginsGuide:   container.layoutMarginsGuide
            case .readableContentGuide: container.readableContentGuide
            }
            topTarget      = lg.topAnchor
            bottomTarget   = lg.bottomAnchor
            leadingTarget  = lg.leadingAnchor
            trailingTarget = lg.trailingAnchor
            centerXTarget  = lg.centerXAnchor
            centerYTarget  = lg.centerYAnchor
        } else {
            topTarget      = container.topAnchor
            bottomTarget   = container.bottomAnchor
            leadingTarget  = container.leadingAnchor
            trailingTarget = container.trailingAnchor
            centerXTarget  = container.centerXAnchor
            centerYTarget  = container.centerYAnchor
        }

        var constraints: [NSLayoutConstraint] = []

        // --- Horizontal axis ---
        let hasLeading  = edges.contains(.leading)
        let hasTrailing = edges.contains(.trailing)

        if hasLeading {
            constraints.append(
                child.leadingAnchor.constraint(
                    equalTo: leadingTarget, constant: insets.left))
        }
        if hasTrailing {
            constraints.append(
                child.trailingAnchor.constraint(
                    equalTo: trailingTarget, constant: -insets.right))
        }

        if !hasLeading && !hasTrailing {
            // No horizontal edge: center and prevent overflow.
            constraints.append(
                child.centerXAnchor.constraint(equalTo: centerXTarget))
            constraints.append(
                child.leadingAnchor.constraint(
                    greaterThanOrEqualTo: leadingTarget, constant: insets.left))
            constraints.append(
                child.trailingAnchor.constraint(
                    lessThanOrEqualTo: trailingTarget, constant: -insets.right))
        } else if hasLeading && !hasTrailing {
            constraints.append(
                child.trailingAnchor.constraint(
                    lessThanOrEqualTo: trailingTarget, constant: -insets.right))
        } else if !hasLeading && hasTrailing {
            constraints.append(
                child.leadingAnchor.constraint(
                    greaterThanOrEqualTo: leadingTarget, constant: insets.left))
        }

        // --- Vertical axis ---
        let hasTop    = edges.contains(.top)
        let hasBottom = edges.contains(.bottom)

        if hasTop {
            constraints.append(
                child.topAnchor.constraint(
                    equalTo: topTarget, constant: insets.top))
        }
        if hasBottom {
            constraints.append(
                child.bottomAnchor.constraint(
                    equalTo: bottomTarget, constant: -insets.bottom))
        }

        if !hasTop && !hasBottom {
            // No vertical edge: center and prevent overflow.
            constraints.append(
                child.centerYAnchor.constraint(equalTo: centerYTarget))
            constraints.append(
                child.topAnchor.constraint(
                    greaterThanOrEqualTo: topTarget, constant: insets.top))
            constraints.append(
                child.bottomAnchor.constraint(
                    lessThanOrEqualTo: bottomTarget, constant: -insets.bottom))
        } else if hasTop && !hasBottom {
            constraints.append(
                child.bottomAnchor.constraint(
                    lessThanOrEqualTo: bottomTarget, constant: -insets.bottom))
        } else if !hasTop && hasBottom {
            constraints.append(
                child.topAnchor.constraint(
                    greaterThanOrEqualTo: topTarget, constant: insets.top))
        }

        NSLayoutConstraint.activate(constraints)
        return container
    }
}

// MARK: - RepresentableNode extensions

extension RepresentableNode {
    /// Pins the view to its superview's edges.
    ///
    /// Unspecified axes center the child and add inequality constraints to stay in bounds.
    public func pinToSuperview(
        edges: LayoutEdge = .all,
        insets: UIEdgeInsets = .zero
    ) -> PinnedView<Self> {
        PinnedView(self, edges: edges, insets: insets)
    }

    /// Pins the view to a layout guide of its superview.
    ///
    /// - Parameters:
    ///   - guide: The layout guide to pin to (e.g. `.safeAreaLayoutGuide`).
    ///   - edges: Which edges to pin. Defaults to `.all`.
    ///   - insets: Insets applied to the pinned edges.
    public func pin(
        to guide: LayoutGuideReference,
        edges: LayoutEdge = .all,
        insets: UIEdgeInsets = .zero
    ) -> PinnedView<Self> {
        PinnedView(self, guide: guide, edges: edges, insets: insets)
    }
}
