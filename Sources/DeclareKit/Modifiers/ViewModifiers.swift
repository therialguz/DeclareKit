import UIKit

extension RepresentableNode {
    func with(_ proxy: @escaping (Self.Representable) -> Void) -> Modifier<Self> {
        Modifier(self, proxy)
    }
}

// MARK: - Layer modifiers
extension RepresentableNode {
    func layer(backgroundColor: @autoclosure @escaping () -> CGColor) -> Modifier<Self> {
        Modifier(self) { $0.layer.backgroundColor = backgroundColor() }
    }

    func layer(backgroundColor: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { $0.layer.backgroundColor = backgroundColor().cgColor }
    }

    func layer(cornerRadius: @autoclosure @escaping () -> CGFloat) -> Modifier<Self> {
        Modifier(self) { $0.layer.cornerRadius = cornerRadius() }
    }

    func layer(borderWidth: @autoclosure @escaping () -> CGFloat) -> Modifier<Self> {
        Modifier(self) { $0.layer.borderWidth = borderWidth() }
    }

    func layer(borderColor: @autoclosure @escaping () -> CGColor) -> Modifier<Self> {
        Modifier(self) { $0.layer.borderColor = borderColor() }
    }

    func layer(borderColor: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { $0.layer.borderColor = borderColor().cgColor }
    }
}

extension RepresentableNode {
    func backgroundColor(_ backgroundColor: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { $0.backgroundColor = backgroundColor() }
    }
    
    func alpha(_ alpha: @autoclosure @escaping () -> CGFloat) -> Modifier<Self> {
        Modifier(self) { $0.alpha = alpha() }
    }

    func isHidden(_ isHidden: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.isHidden = isHidden() }
    }
}
