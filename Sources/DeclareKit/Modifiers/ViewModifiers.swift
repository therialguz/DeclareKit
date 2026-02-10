import UIKit

extension RepresentableNode {
    func with(_ proxy: @escaping (Self.Representable) -> Void)-> Modifier<Self> {
        Modifier(self, proxy)
    }
}

// MARK: - Layer modifiers
extension RepresentableNode {
    func layer(backgroundColor: @autoclosure @escaping () -> CGColor) -> Modifier<Self> {
        Modifier(self) { $0.layer.backgroundColor = backgroundColor() }
    }

    func layer(backgroundColor: @autoclosure @escaping () -> UIColor)-> Modifier<Self> {
        Modifier(self) { $0.layer.backgroundColor = backgroundColor().cgColor }
    }

    func layer(cornerRadius: @autoclosure @escaping () -> CGFloat)-> Modifier<Self> {
        Modifier(self) { $0.layer.cornerRadius = cornerRadius() }
    }

    func layer(borderWidth: @autoclosure @escaping () -> CGFloat)-> Modifier<Self> {
        Modifier(self) { $0.layer.borderWidth = borderWidth() }
    }

    func layer(borderColor: @autoclosure @escaping () -> CGColor)-> Modifier<Self> {
        Modifier(self) { $0.layer.borderColor = borderColor() }
    }

    func layer(borderColor: @autoclosure @escaping () -> UIColor)-> Modifier<Self> {
        Modifier(self) { $0.layer.borderColor = borderColor().cgColor }
    }
    
    func layer(masksToBounds: @autoclosure @escaping () -> Bool)-> Modifier<Self> {
        Modifier(self) { $0.layer.masksToBounds = masksToBounds() }
    }
    
    func layer(shadowColor: @autoclosure @escaping () -> CGColor)-> Modifier<Self> {
        Modifier(self) { $0.layer.shadowColor = shadowColor() }
    }
    
    func layer(shadowColor: @autoclosure @escaping () -> UIColor)-> Modifier<Self> {
        Modifier(self) { $0.layer.shadowColor = shadowColor().cgColor }
    }
    
    func layer(shadowOpacity: @autoclosure @escaping () -> Float)-> Modifier<Self> {
        Modifier(self) { $0.layer.shadowOpacity = shadowOpacity() }
    }
    
    func layer(shadowRadius: @autoclosure @escaping () -> CGFloat)-> Modifier<Self> {
        Modifier(self) { $0.layer.shadowRadius = shadowRadius() }
    }
    
    func layer(shadowOffset: @autoclosure @escaping () -> CGSize)-> Modifier<Self> {
        Modifier(self) { $0.layer.shadowOffset = shadowOffset() }
    }
    
    func layer(opacity: @autoclosure @escaping () -> Float)-> Modifier<Self> {
        Modifier(self) { $0.layer.opacity = opacity() }
    }
    
    func layer(zPosition: @autoclosure @escaping () -> CGFloat)-> Modifier<Self> {
        Modifier(self) { $0.layer.zPosition = zPosition() }
    }
}

extension RepresentableNode {
    func backgroundColor(_ backgroundColor: @autoclosure @escaping () -> UIColor)-> Modifier<Self> {
        Modifier(self) { $0.backgroundColor = backgroundColor() }
    }
    
    func alpha(_ alpha: @autoclosure @escaping () -> CGFloat)-> Modifier<Self> {
        Modifier(self) { $0.alpha = alpha() }
    }

    func isHidden(_ isHidden: @autoclosure @escaping () -> Bool)-> Modifier<Self> {
        Modifier(self) { $0.isHidden = isHidden() }
    }
    
    func clipsToBounds(_ clipsToBounds: @autoclosure @escaping () -> Bool)-> Modifier<Self> {
        Modifier(self) { $0.clipsToBounds = clipsToBounds() }
    }
    
    func tintColor(_ tintColor: @autoclosure @escaping () -> UIColor)-> Modifier<Self> {
        Modifier(self) { $0.tintColor = tintColor() }
    }
    
    func transform3D(_ transform3D: @autoclosure @escaping () -> CATransform3D)-> Modifier<Self> {
        Modifier(self) { $0.transform3D = transform3D() }
    }
    
    func tag(_ tag: @autoclosure @escaping () -> Int)-> Modifier<Self> {
        Modifier(self) { $0.tag = tag() }
    }
}
