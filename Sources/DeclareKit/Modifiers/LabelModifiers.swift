import UIKit

// MARK: - UILabel modifiers
extension RepresentableNode where Representable == UILabel {
    func textColor(_ color: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { $0.textColor = color() }
    }

    func font(_ font: @autoclosure @escaping () -> UIFont) -> Modifier<Self> {
        Modifier(self) { $0.font = font() }
    }

    func numberOfLines(_ lines: @autoclosure @escaping () -> Int) -> Modifier<Self> {
        Modifier(self) { $0.numberOfLines = lines() }
    }
}
