import UIKit

/// A controller that represents an empty controller.
///
/// This type is created by `@ControllerBuilder` when a builder block is empty.
/// It mirrors `EmptyView` but for controllers.
@MainActor
struct EmptyController: RepresentableController {
    init() {}
    
    func buildController() -> UIViewController {
        UIViewController()
    }
    
    func buildControllerList() -> [UIViewController] {
        []
    }
}

/// Make Optional conform to RepresentableController when wrapped type conforms.
extension Optional: RepresentableController where Wrapped: RepresentableController {
    func buildController() -> UIViewController {
        switch self {
        case .some(let controller):
            return controller.buildController()
        case .none:
            return EmptyController().buildController()
        }
    }
    
    func buildControllerList() -> [UIViewController] {
        switch self {
        case .some(let controller):
            return controller.buildControllerList()
        case .none:
            return []
        }
    }
}
