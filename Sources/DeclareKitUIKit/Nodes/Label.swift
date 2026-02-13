import UIKit
import DeclareKitCore

/// A reactive `UILabel` component.
public struct Label: RepresentableNode {
    private let text: () -> String

    /// Creates a label with a reactive text source.
    public init(_ text: @autoclosure @escaping () -> String) {
        self.text = text
    }

    /// Builds the configured `UILabel`.
    public func build(in context: BuildContext) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        createEffect { [weak label] in
            guard let label else { return }
            label.text = self.text()
        }
        return label
    }
}
