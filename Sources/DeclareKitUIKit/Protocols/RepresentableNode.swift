import UIKit

@MainActor
public protocol RepresentableNode {
    associatedtype Representable: UIView

    func build() -> Representable

    func buildList() -> [UIView]
}

extension RepresentableNode {
    public func buildList() -> [UIView] {
        [build()]
    }
}
