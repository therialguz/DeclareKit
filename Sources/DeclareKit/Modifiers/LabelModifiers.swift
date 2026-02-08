import UIKit

// MARK: - UILabel modifiers
extension RepresentableNode where Representable == UILabel {
    func textColor(_ color: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { label in
            createEffect { [weak label] in
                guard let label else { return }
                label.textColor = color()
            }
        }
    }

    func font(_ font: @autoclosure @escaping () -> UIFont) -> Modifier<Self> {
        Modifier(self) { label in
            createEffect { [weak label] in
                guard let label else { return }
                label.font = font()
            }
        }
    }

    func numberOfLines(_ lines: @autoclosure @escaping () -> Int) -> Modifier<Self> {
        Modifier(self) { label in
            createEffect { [weak label] in
                guard let label else { return }
                label.numberOfLines = lines()
            }
        }
    }
}
