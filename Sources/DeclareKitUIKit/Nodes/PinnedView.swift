import UIKit

// MARK: - RepresentableNode extensions

extension RepresentableNode {
    /// Pins the view to its parent's edges.
    ///
    /// Unspecified axes center the child and add inequality constraints to stay in bounds.
    public func pinToSuperview(
        edges: LayoutEdge = .all,
        insets: UIEdgeInsets = .zero
    ) -> LayoutModifier<Self> {
        pin(to: nil, edges: edges, insets: insets)
    }

    /// Pins the view to a layout guide of its parent.
    ///
    /// - Parameters:
    ///   - guide: The layout guide to pin to (e.g. `.safeAreaLayoutGuide`).
    ///   - edges: Which edges to pin. Defaults to `.all`.
    ///   - insets: Insets applied to the pinned edges.
    public func pin(
        to guide: LayoutGuideReference,
        edges: LayoutEdge = .all,
        insets: UIEdgeInsets = .zero
    ) -> LayoutModifier<Self> {
        pin(to: Optional(guide), edges: edges, insets: insets)
    }

    private func pin(
        to guide: LayoutGuideReference?,
        edges: LayoutEdge,
        insets: UIEdgeInsets
    ) -> LayoutModifier<Self> {
        LayoutModifier(self) { view, context in
            print("View: \(view), context: \(context)")
            guard let parent = context.parent else { return }
            
            parent.addSubview(view)

            // Resolve anchor source: layout guide or parent itself.
            let topTarget: NSLayoutYAxisAnchor
            let bottomTarget: NSLayoutYAxisAnchor
            let leadingTarget: NSLayoutXAxisAnchor
            let trailingTarget: NSLayoutXAxisAnchor
            let centerXTarget: NSLayoutXAxisAnchor
            let centerYTarget: NSLayoutYAxisAnchor

            if let guide {
                let layoutGuide: UILayoutGuide = switch guide {
                case .safeAreaLayoutGuide:  parent.safeAreaLayoutGuide
                case .layoutMarginsGuide:   parent.layoutMarginsGuide
                case .readableContentGuide: parent.readableContentGuide
                }
                topTarget      = layoutGuide.topAnchor
                bottomTarget   = layoutGuide.bottomAnchor
                leadingTarget  = layoutGuide.leadingAnchor
                trailingTarget = layoutGuide.trailingAnchor
                centerXTarget  = layoutGuide.centerXAnchor
                centerYTarget  = layoutGuide.centerYAnchor
            } else {
                topTarget      = parent.topAnchor
                bottomTarget   = parent.bottomAnchor
                leadingTarget  = parent.leadingAnchor
                trailingTarget = parent.trailingAnchor
                centerXTarget  = parent.centerXAnchor
                centerYTarget  = parent.centerYAnchor
            }

            var constraints: [NSLayoutConstraint] = []

            // --- Horizontal axis ---
            let hasLeading  = edges.contains(.leading)
            let hasTrailing = edges.contains(.trailing)

            if hasLeading {
                constraints.append(
                    view.leadingAnchor.constraint(
                        equalTo: leadingTarget, constant: insets.left))
            }
            if hasTrailing {
                constraints.append(
                    view.trailingAnchor.constraint(
                        equalTo: trailingTarget, constant: -insets.right))
            }

            if !hasLeading && !hasTrailing {
                constraints.append(
                    view.centerXAnchor.constraint(equalTo: centerXTarget))
                constraints.append(
                    view.leadingAnchor.constraint(
                        greaterThanOrEqualTo: leadingTarget, constant: insets.left))
                constraints.append(
                    view.trailingAnchor.constraint(
                        lessThanOrEqualTo: trailingTarget, constant: -insets.right))
            } else if hasLeading && !hasTrailing {
                constraints.append(
                    view.trailingAnchor.constraint(
                        lessThanOrEqualTo: trailingTarget, constant: -insets.right))
            } else if !hasLeading && hasTrailing {
                constraints.append(
                    view.leadingAnchor.constraint(
                        greaterThanOrEqualTo: leadingTarget, constant: insets.left))
            }

            // --- Vertical axis ---
            let hasTop    = edges.contains(.top)
            let hasBottom = edges.contains(.bottom)

            if hasTop {
                constraints.append(
                    view.topAnchor.constraint(
                        equalTo: topTarget, constant: insets.top))
            }
            if hasBottom {
                constraints.append(
                    view.bottomAnchor.constraint(
                        equalTo: bottomTarget, constant: -insets.bottom))
            }

            if !hasTop && !hasBottom {
                constraints.append(
                    view.centerYAnchor.constraint(equalTo: centerYTarget))
                constraints.append(
                    view.topAnchor.constraint(
                        greaterThanOrEqualTo: topTarget, constant: insets.top))
                constraints.append(
                    view.bottomAnchor.constraint(
                        lessThanOrEqualTo: bottomTarget, constant: -insets.bottom))
            } else if hasTop && !hasBottom {
                constraints.append(
                    view.bottomAnchor.constraint(
                        lessThanOrEqualTo: bottomTarget, constant: -insets.bottom))
            } else if !hasTop && hasBottom {
                constraints.append(
                    view.topAnchor.constraint(
                        greaterThanOrEqualTo: topTarget, constant: insets.top))
            }

            NSLayoutConstraint.activate(constraints)
        }
    }
}
