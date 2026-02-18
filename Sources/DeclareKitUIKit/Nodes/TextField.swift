import UIKit
import DeclareKitCore

/// A reactive `UITextField` component with two-way binding.
public struct TextField: RepresentableNode {
    public typealias Representable = UITextField
    
    private let text: Binding<String>

    /// Creates a text field with a two-way text binding.
    public init(text: Binding<String>) {
        self.text = text
    }

    /// Builds the configured `UITextField`.
    public func build(in context: BuildContext) {
        let textField = UITextField()
        context.insertChild(textField, nil)
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
    }
}


#Preview {
    ViewController {
        Stack(.vertical) {
            @Signal var text: String = "Hello World"
            
            Label("This is the example")
            
            Label(text)
                .backgroundColor(.blue)
            
            TextField(text: $text)
                .placeholder("Enter your text here")
                .backgroundColor(.green)
        }
        .pin(to: .safeAreaLayoutGuide)
        .backgroundColor(.red)
    }
    .buildController()
}
