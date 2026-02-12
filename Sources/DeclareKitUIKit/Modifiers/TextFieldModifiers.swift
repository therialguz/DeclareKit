import UIKit

// MARK: - UITextField modifiers
extension RepresentableNode where Representable == UITextField {
    /// Sets `placeholder`.
    public func placeholder(_ placeholder: @autoclosure @escaping () -> String?) -> Modifier<Self> {
        Modifier(self) { $0.placeholder = placeholder() }
    }

    /// Sets `font`.
    public func font(_ font: @autoclosure @escaping () -> UIFont) -> Modifier<Self> {
        Modifier(self) { $0.font = font() }
    }

    /// Sets `textColor`.
    public func textColor(_ color: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { $0.textColor = color() }
    }

    /// Sets `textAlignment`.
    public func textAlignment(_ alignment: @autoclosure @escaping () -> NSTextAlignment) -> Modifier<Self> {
        Modifier(self) { $0.textAlignment = alignment() }
    }

    /// Sets `keyboardType`.
    public func keyboardType(_ type: @autoclosure @escaping () -> UIKeyboardType) -> Modifier<Self> {
        Modifier(self) { $0.keyboardType = type() }
    }

    /// Sets `returnKeyType`.
    public func returnKeyType(_ type: @autoclosure @escaping () -> UIReturnKeyType) -> Modifier<Self> {
        Modifier(self) { $0.returnKeyType = type() }
    }

    /// Sets `isSecureTextEntry`.
    public func isSecureTextEntry(_ isSecure: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.isSecureTextEntry = isSecure() }
    }

    /// Sets `autocapitalizationType`.
    public func autocapitalizationType(_ type: @autoclosure @escaping () -> UITextAutocapitalizationType) -> Modifier<Self> {
        Modifier(self) { $0.autocapitalizationType = type() }
    }

    /// Sets `borderStyle`.
    public func borderStyle(_ style: @autoclosure @escaping () -> UITextField.BorderStyle) -> Modifier<Self> {
        Modifier(self) { $0.borderStyle = style() }
    }
}
