import UIKit

// MARK: - UIStackView modifiers
extension RepresentableNode where Representable == UIStackView {
    func margins(_ insets: @autoclosure @escaping () -> UIEdgeInsets) -> Modifier<Self> {
        Modifier(self) { stack in
            createEffect { [weak stack] in
                guard let stack else { return }
                stack.layoutMargins = insets()
                stack.isLayoutMarginsRelativeArrangement = true
            }
        }
    }
}
