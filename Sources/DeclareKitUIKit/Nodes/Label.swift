import UIKit
import DeclareKitCore

public struct Label: RepresentableNode {
    private let text: () -> String

    public init(_ text: @autoclosure @escaping () -> String) {
        self.text = text
    }

    public func build() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        createEffect { [weak label] in
            guard let label else { return }
            label.text = self.text()
        }
        return label
    }
}
