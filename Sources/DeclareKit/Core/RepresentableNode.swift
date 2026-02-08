import UIKit

@MainActor
protocol RepresentableNode {
    associatedtype Representable: UIView

    func build() -> Representable

    func buildList() -> [UIView]
}

extension RepresentableNode {
    func buildList() -> [UIView] {
        [build()]
    }
}
