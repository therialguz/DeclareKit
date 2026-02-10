import UIKit

// MARK: - UILabel modifiers
extension RepresentableNode where Representable == UILabel {
    public func textColor(_ color: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { $0.textColor = color() }
    }

    public func font(_ font: @autoclosure @escaping () -> UIFont) -> Modifier<Self> {
        Modifier(self) { $0.font = font() }
    }

    public func numberOfLines(_ lines: @autoclosure @escaping () -> Int) -> Modifier<Self> {
        Modifier(self) { $0.numberOfLines = lines() }
    }
}
