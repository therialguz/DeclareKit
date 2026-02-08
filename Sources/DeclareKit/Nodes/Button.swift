import UIKit

struct Button: RepresentableNode {
    private let title: () -> String
    private let action: () -> Void

    init(_ title: @autoclosure @escaping () -> String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    func build() -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction { _ in action() }, for: .touchUpInside)
        createEffect { [weak button] in
            guard let button else { return }
            button.setTitle(self.title(), for: .normal)
        }
        return button
    }
}
