import UIKit

extension RepresentableNode {
    /// Applies an arbitrary mutation closure to the built view.
    public func with(_ proxy: @escaping (Self.Representable) -> Void) -> Modifier<Self> {
        Modifier(self, proxy)
    }
}

// MARK: - Layer modifiers
extension RepresentableNode {
    /// Sets `layer.backgroundColor` using a `CGColor`.
    public func layer(backgroundColor: @autoclosure @escaping () -> CGColor) -> Modifier<Self> {
        Modifier(self) { $0.layer.backgroundColor = backgroundColor() }
    }

    /// Sets `layer.backgroundColor` using a `UIColor`.
    public func layer(backgroundColor: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { $0.layer.backgroundColor = backgroundColor().cgColor }
    }

    /// Sets `layer.cornerRadius`.
    public func layer(cornerRadius: @autoclosure @escaping () -> CGFloat) -> Modifier<Self> {
        Modifier(self) { $0.layer.cornerRadius = cornerRadius() }
    }

    /// Sets `layer.borderWidth`.
    public func layer(borderWidth: @autoclosure @escaping () -> CGFloat) -> Modifier<Self> {
        Modifier(self) { $0.layer.borderWidth = borderWidth() }
    }

    /// Sets `layer.borderColor` using a `CGColor`.
    public func layer(borderColor: @autoclosure @escaping () -> CGColor) -> Modifier<Self> {
        Modifier(self) { $0.layer.borderColor = borderColor() }
    }

    /// Sets `layer.borderColor` using a `UIColor`.
    public func layer(borderColor: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { $0.layer.borderColor = borderColor().cgColor }
    }

    /// Sets `layer.masksToBounds`.
    public func layer(masksToBounds: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.layer.masksToBounds = masksToBounds() }
    }

    /// Sets `layer.shadowColor` using a `CGColor`.
    public func layer(shadowColor: @autoclosure @escaping () -> CGColor) -> Modifier<Self> {
        Modifier(self) { $0.layer.shadowColor = shadowColor() }
    }

    /// Sets `layer.shadowColor` using a `UIColor`.
    public func layer(shadowColor: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { $0.layer.shadowColor = shadowColor().cgColor }
    }

    /// Sets `layer.shadowOpacity`.
    public func layer(shadowOpacity: @autoclosure @escaping () -> Float) -> Modifier<Self> {
        Modifier(self) { $0.layer.shadowOpacity = shadowOpacity() }
    }

    /// Sets `layer.shadowRadius`.
    public func layer(shadowRadius: @autoclosure @escaping () -> CGFloat) -> Modifier<Self> {
        Modifier(self) { $0.layer.shadowRadius = shadowRadius() }
    }

    /// Sets `layer.shadowOffset`.
    public func layer(shadowOffset: @autoclosure @escaping () -> CGSize) -> Modifier<Self> {
        Modifier(self) { $0.layer.shadowOffset = shadowOffset() }
    }

    /// Sets `layer.opacity`.
    public func layer(opacity: @autoclosure @escaping () -> Float) -> Modifier<Self> {
        Modifier(self) { $0.layer.opacity = opacity() }
    }

    /// Sets `layer.zPosition`.
    public func layer(zPosition: @autoclosure @escaping () -> CGFloat) -> Modifier<Self> {
        Modifier(self) { $0.layer.zPosition = zPosition() }
    }
}

extension RepresentableNode {
    /// Sets `backgroundColor`.
    public func backgroundColor(_ backgroundColor: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { $0.backgroundColor = backgroundColor() }
    }

    /// Sets `alpha`.
    public func alpha(_ alpha: @autoclosure @escaping () -> CGFloat) -> Modifier<Self> {
        Modifier(self) { $0.alpha = alpha() }
    }

    /// Sets `isHidden`.
    public func isHidden(_ isHidden: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.isHidden = isHidden() }
    }

    /// Sets `clipsToBounds`.
    public func clipsToBounds(_ clipsToBounds: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.clipsToBounds = clipsToBounds() }
    }

    /// Sets `tintColor`.
    public func tintColor(_ tintColor: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { $0.tintColor = tintColor() }
    }

    /// Sets `transform3D`.
    public func transform3D(_ transform3D: @autoclosure @escaping () -> CATransform3D) -> Modifier<Self> {
        Modifier(self) { $0.transform3D = transform3D() }
    }

    /// Sets `tag`.
    public func tag(_ tag: @autoclosure @escaping () -> Int) -> Modifier<Self> {
        Modifier(self) { $0.tag = tag() }
    }
}
