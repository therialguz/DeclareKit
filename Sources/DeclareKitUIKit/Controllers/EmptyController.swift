import UIKit

/// A controller that represents an empty controller.
///
/// This type is created by `@ControllerBuilder` when a builder block is empty.
/// It mirrors `EmptyView` but for controllers.
@MainActor
public struct EmptyController: RepresentableController {
    public init() {}

    public func buildController() -> UIViewController {
        UIViewController()
    }

    public func buildControllerList() -> [UIViewController] {
        []
    }
}

/// Make Optional conform to RepresentableController when wrapped type conforms.
extension Optional: RepresentableController where Wrapped: RepresentableController {
    public func buildController() -> UIViewController {
        switch self {
        case .some(let controller):
            return controller.buildController()
        case .none:
            return EmptyController().buildController()
        }
    }

    public func buildControllerList() -> [UIViewController] {
        switch self {
        case .some(let controller):
            return controller.buildControllerList()
        case .none:
            return []
        }
    }
}
