import UIKit

// MARK: - Width constraints

extension RepresentableNode {
    /// Adds a `widthAnchor.constraint(equalToConstant:)` to the view.
    public func widthAnchor(equalToConstant constant: CGFloat) -> Modifier<Self> {
        Modifier(self, reactive: false) { view in
            view.widthAnchor.constraint(equalToConstant: constant).isActive = true
        }
    }

    /// Adds a `widthAnchor.constraint(greaterThanOrEqualToConstant:)` to the view.
    public func widthAnchor(greaterThanOrEqualToConstant constant: CGFloat) -> Modifier<Self> {
        Modifier(self, reactive: false) { view in
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
        }
    }

    /// Adds a `widthAnchor.constraint(lessThanOrEqualToConstant:)` to the view.
    public func widthAnchor(lessThanOrEqualToConstant constant: CGFloat) -> Modifier<Self> {
        Modifier(self, reactive: false) { view in
            view.widthAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
        }
    }
}

// MARK: - Height constraints

extension RepresentableNode {
    /// Adds a `heightAnchor.constraint(equalToConstant:)` to the view.
    public func heightAnchor(equalToConstant constant: CGFloat) -> Modifier<Self> {
        Modifier(self, reactive: false) { view in
            view.heightAnchor.constraint(equalToConstant: constant).isActive = true
        }
    }

    /// Adds a `heightAnchor.constraint(greaterThanOrEqualToConstant:)` to the view.
    public func heightAnchor(greaterThanOrEqualToConstant constant: CGFloat) -> Modifier<Self> {
        Modifier(self, reactive: false) { view in
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
        }
    }

    /// Adds a `heightAnchor.constraint(lessThanOrEqualToConstant:)` to the view.
    public func heightAnchor(lessThanOrEqualToConstant constant: CGFloat) -> Modifier<Self> {
        Modifier(self, reactive: false) { view in
            view.heightAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
        }
    }
}

// MARK: - Aspect ratio

extension RepresentableNode {
    /// Constrains the view's width relative to another dimension anchor.
    ///
    /// For example, to set a 16:9 aspect ratio:
    /// ```swift
    /// .widthAnchor(equalTo: .heightAnchor, multiplier: 16.0 / 9.0)
    /// ```
    public func widthAnchor(
        equalTo dimension: DimensionAnchor,
        multiplier: CGFloat
    ) -> Modifier<Self> {
        Modifier(self, reactive: false) { view in
            let anchor: NSLayoutDimension = switch dimension {
            case .widthAnchor: view.widthAnchor
            case .heightAnchor: view.heightAnchor
            }
            view.widthAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
        }
    }

    /// Constrains the view's height relative to another dimension anchor.
    ///
    /// For example, to set a 9:16 aspect ratio:
    /// ```swift
    /// .heightAnchor(equalTo: .widthAnchor, multiplier: 16.0 / 9.0)
    /// ```
    public func heightAnchor(
        equalTo dimension: DimensionAnchor,
        multiplier: CGFloat
    ) -> Modifier<Self> {
        Modifier(self, reactive: false) { view in
            let anchor: NSLayoutDimension = switch dimension {
            case .widthAnchor: view.widthAnchor
            case .heightAnchor: view.heightAnchor
            }
            view.heightAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
        }
    }
}

// MARK: - Layout priorities

extension RepresentableNode {
    /// Sets `contentHuggingPriority` for the given axis.
    public func contentHuggingPriority(
        _ priority: UILayoutPriority,
        for axis: NSLayoutConstraint.Axis
    ) -> Modifier<Self> {
        Modifier(self, reactive: false) { view in
            view.setContentHuggingPriority(priority, for: axis)
        }
    }

    /// Sets `contentCompressionResistancePriority` for the given axis.
    public func contentCompressionResistancePriority(
        _ priority: UILayoutPriority,
        for axis: NSLayoutConstraint.Axis
    ) -> Modifier<Self> {
        Modifier(self, reactive: false) { view in
            view.setContentCompressionResistancePriority(priority, for: axis)
        }
    }
}
