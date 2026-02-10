import UIKit

// MARK: - UIStackView modifiers
extension RepresentableNode where Representable == UIStackView {
    /// Sets layout margins and enables margin-relative arrangement.
    public func margins(_ insets: @autoclosure @escaping () -> UIEdgeInsets) -> Modifier<Self> {
        Modifier(self) {
            $0.layoutMargins = insets()
            $0.isLayoutMarginsRelativeArrangement = true
        }
    }
}
