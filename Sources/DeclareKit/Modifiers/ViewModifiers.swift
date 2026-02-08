import UIKit

extension RepresentableNode {
    /// Non-reactive modifier — applies once at build time (equivalent to SolidJS `untrack`).
    func with(_ proxy: @escaping (Self.Representable) -> Void) -> Modifier<Self> {
        Modifier(self, reactive: false, proxy)
    }
}

// MARK: - Layer modifiers
extension RepresentableNode {
    func backgroundColor(_ color: @autoclosure @escaping () -> CGColor) -> Modifier<Self> {
        Modifier(self) { $0.layer.backgroundColor = color() }
    }

    func backgroundColor(_ color: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { $0.layer.backgroundColor = color().cgColor }
    }

    func cornerRadius(_ radius: @autoclosure @escaping () -> CGFloat) -> Modifier<Self> {
        Modifier(self) { $0.layer.cornerRadius = radius() }
    }

    func borderWidth(_ width: @autoclosure @escaping () -> CGFloat) -> Modifier<Self> {
        Modifier(self) { $0.layer.borderWidth = width() }
    }

    func borderColor(_ color: @autoclosure @escaping () -> CGColor) -> Modifier<Self> {
        Modifier(self) { $0.layer.borderColor = color() }
    }

    func borderColor(_ color: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { $0.layer.borderColor = color().cgColor }
    }

    func alpha(_ value: @autoclosure @escaping () -> CGFloat) -> Modifier<Self> {
        Modifier(self) { $0.alpha = value() }
    }

    func isHidden(_ hidden: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.isHidden = hidden() }
    }

    /// Escape hatch for custom reactive bindings on the built UIView.
    func withEffect(_ effect: @escaping (Self.Representable) -> Void) -> Modifier<Self> {
        Modifier(self) { effect($0) }
    }
}
