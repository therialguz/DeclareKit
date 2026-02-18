import UIKit
import DeclareKitCore

/// A reactive `UITextField` component with two-way binding.
public struct TextField: RepresentableNode {
    private let text: Binding<String>

    /// Creates a text field with a two-way text binding.
    public init(text: Binding<String>) {
        self.text = text
    }

    /// Builds the configured `UITextField`.
    public func build(in context: BuildContext) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false

        // UITextField → Binding (user typing)
        textField.addAction(
            UIAction { _ in
                text.wrappedValue = textField.text ?? ""
            },
            for: .editingChanged
        )

        // Binding → UITextField (external changes)
        createEffect { [weak textField] in
            guard let textField else { return }
            textField.text = text.wrappedValue
        }

        return textField
    }
}

struct Test: View {
    @Signal var text: String = "Hello World"
    
    var body: some RepresentableNode {
        Stack(.vertical) {
            Label(text)
            
            TextField(text: $text)
                .placeholder("Enter your text here")
        }
    }
}
