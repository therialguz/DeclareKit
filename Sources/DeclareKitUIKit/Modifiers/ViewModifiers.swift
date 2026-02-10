import UIKit

extension RepresentableNode {
    public func with(_ proxy: @escaping (Self.Representable) -> Void)-> Modifier<Self> {
        Modifier(self, proxy)
    }
}

// MARK: - Layer modifiers
extension RepresentableNode {
    public func layer(backgroundColor: @autoclosure @escaping () -> CGColor) -> Modifier<Self> {
        Modifier(self) { $0.layer.backgroundColor = backgroundColor() }
    }

    public func layer(backgroundColor: @autoclosure @escaping () -> UIColor)-> Modifier<Self> {
        Modifier(self) { $0.layer.backgroundColor = backgroundColor().cgColor }
    }

    public func layer(cornerRadius: @autoclosure @escaping () -> CGFloat)-> Modifier<Self> {
        Modifier(self) { $0.layer.cornerRadius = cornerRadius() }
    }

    public func layer(borderWidth: @autoclosure @escaping () -> CGFloat)-> Modifier<Self> {
        Modifier(self) { $0.layer.borderWidth = borderWidth() }
    }

    public func layer(borderColor: @autoclosure @escaping () -> CGColor)-> Modifier<Self> {
        Modifier(self) { $0.layer.borderColor = borderColor() }
    }

    public func layer(borderColor: @autoclosure @escaping () -> UIColor)-> Modifier<Self> {
        Modifier(self) { $0.layer.borderColor = borderColor().cgColor }
    }

    public func layer(masksToBounds: @autoclosure @escaping () -> Bool)-> Modifier<Self> {
        Modifier(self) { $0.layer.masksToBounds = masksToBounds() }
    }

    public func layer(shadowColor: @autoclosure @escaping () -> CGColor)-> Modifier<Self> {
        Modifier(self) { $0.layer.shadowColor = shadowColor() }
    }

    public func layer(shadowColor: @autoclosure @escaping () -> UIColor)-> Modifier<Self> {
        Modifier(self) { $0.layer.shadowColor = shadowColor().cgColor }
    }

    public func layer(shadowOpacity: @autoclosure @escaping () -> Float)-> Modifier<Self> {
        Modifier(self) { $0.layer.shadowOpacity = shadowOpacity() }
    }

    public func layer(shadowRadius: @autoclosure @escaping () -> CGFloat)-> Modifier<Self> {
        Modifier(self) { $0.layer.shadowRadius = shadowRadius() }
    }

    public func layer(shadowOffset: @autoclosure @escaping () -> CGSize)-> Modifier<Self> {
        Modifier(self) { $0.layer.shadowOffset = shadowOffset() }
    }

    public func layer(opacity: @autoclosure @escaping () -> Float)-> Modifier<Self> {
        Modifier(self) { $0.layer.opacity = opacity() }
    }

    public func layer(zPosition: @autoclosure @escaping () -> CGFloat)-> Modifier<Self> {
        Modifier(self) { $0.layer.zPosition = zPosition() }
    }
}

extension RepresentableNode {
    public func backgroundColor(_ backgroundColor: @autoclosure @escaping () -> UIColor)-> Modifier<Self> {
        Modifier(self) { $0.backgroundColor = backgroundColor() }
    }

    public func alpha(_ alpha: @autoclosure @escaping () -> CGFloat)-> Modifier<Self> {
        Modifier(self) { $0.alpha = alpha() }
    }

    public func isHidden(_ isHidden: @autoclosure @escaping () -> Bool)-> Modifier<Self> {
        Modifier(self) { $0.isHidden = isHidden() }
    }

    public func clipsToBounds(_ clipsToBounds: @autoclosure @escaping () -> Bool)-> Modifier<Self> {
        Modifier(self) { $0.clipsToBounds = clipsToBounds() }
    }

    public func tintColor(_ tintColor: @autoclosure @escaping () -> UIColor)-> Modifier<Self> {
        Modifier(self) { $0.tintColor = tintColor() }
    }

    public func transform3D(_ transform3D: @autoclosure @escaping () -> CATransform3D)-> Modifier<Self> {
        Modifier(self) { $0.transform3D = transform3D() }
    }

    public func tag(_ tag: @autoclosure @escaping () -> Int)-> Modifier<Self> {
        Modifier(self) { $0.tag = tag() }
    }
}
