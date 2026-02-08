import UIKit

extension RepresentableNode {
    func with(_ proxy: @escaping (Self.Representable) -> Void) -> Modifier<Self> {
        Modifier(self, proxy)
    }

    func padding(_ value: CGFloat) -> Padding<Self> {
        Padding(value, { self })
    }
}

// MARK: - Layer modifiers
extension RepresentableNode {
    func backgroundColor(_ color: @autoclosure @escaping () -> CGColor) -> Modifier<Self> {
        Modifier(self) { view in
            createEffect { [weak view] in
                guard let view else { return }
                view.layer.backgroundColor = color()
            }
        }
    }

    func backgroundColor(_ color: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { view in
            createEffect { [weak view] in
                guard let view else { return }
                view.layer.backgroundColor = color().cgColor
            }
        }
    }

    func cornerRadius(_ radius: @autoclosure @escaping () -> CGFloat) -> Modifier<Self> {
        Modifier(self) { view in
            createEffect { [weak view] in
                guard let view else { return }
                view.layer.cornerRadius = radius()
            }
        }
    }

    func borderWidth(_ width: @autoclosure @escaping () -> CGFloat) -> Modifier<Self> {
        Modifier(self) { view in
            createEffect { [weak view] in
                guard let view else { return }
                view.layer.borderWidth = width()
            }
        }
    }

    func borderColor(_ color: @autoclosure @escaping () -> CGColor) -> Modifier<Self> {
        Modifier(self) { view in
            createEffect { [weak view] in
                guard let view else { return }
                view.layer.borderColor = color()
            }
        }
    }

    func borderColor(_ color: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { view in
            createEffect { [weak view] in
                guard let view else { return }
                view.layer.borderColor = color().cgColor
            }
        }
    }

    func alpha(_ value: @autoclosure @escaping () -> CGFloat) -> Modifier<Self> {
        Modifier(self) { view in
            createEffect { [weak view] in
                guard let view else { return }
                view.alpha = value()
            }
        }
    }

    func isHidden(_ hidden: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { view in
            createEffect { [weak view] in
                guard let view else { return }
                view.isHidden = hidden()
            }
        }
    }

    /// Escape hatch for custom reactive bindings on the built UIView.
    func withEffect(_ effect: @escaping (Self.Representable) -> Void) -> Modifier<Self> {
        Modifier(self) { view in
            createEffect { [weak view] in
                guard let view else { return }
                effect(view)
            }
        }
    }
}
