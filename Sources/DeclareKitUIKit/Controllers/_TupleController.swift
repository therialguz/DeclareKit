import UIKit

/// Internal type representing multiple controllers composed together.
///
/// This type is created by `@ControllerBuilder` when multiple controllers are declared
/// in a single block. It mirrors `_TupleNode` but for controllers.
@MainActor
public struct _TupleController<each Child: RepresentableController>: RepresentableController {
    public let children: (repeat each Child)

    public init(_ value: repeat each Child) {
        self.children = (repeat each value)
    }

    public func buildController() -> UIViewController {
        buildControllerList().first ?? UIViewController()
    }

    public func buildControllerList() -> [UIViewController] {
        var controllers: [UIViewController] = []
        for child in repeat each children {
            controllers.append(contentsOf: child.buildControllerList())
        }
        return controllers
    }
}
