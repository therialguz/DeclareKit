import UIKit
import DeclareKitCore

/// A reactive system button component.
///
/// The title closure is tracked reactively, and the action is triggered
/// when the button receives `.touchUpInside`.
public struct Button: RepresentableNode {
    private let title: () -> String
    private let action: () -> Void

    /// Creates a button with a reactive title and tap action.
    public init(_ title: @autoclosure @escaping () -> String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    /// Builds the configured `UIButton`.
    public func build() -> UIButton {
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

extension RepresentableNode where Representable == UIButton {
    /// Sets layout margins and enables margin-relative arrangement.
    public func isEnabled(_ isEnabled: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.isEnabled = isEnabled() }
    }
    
    public func configuration(_ configuration: @autoclosure @escaping () -> UIButton.Configuration) -> Modifier<Self> {
        Modifier(self) { $0.configuration = configuration() }
    }
}
