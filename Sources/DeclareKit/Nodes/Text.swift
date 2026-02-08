import UIKit

struct Text: RepresentableNode {
    private let text: () -> String

    init(_ text: @autoclosure @escaping () -> String) {
        self.text = text
    }

    func build() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        createEffect { [weak label] in
            guard let label else { return }
            label.text = self.text()
        }
        return label
    }
}
