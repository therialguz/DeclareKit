import UIKit

/// A controller that represents an empty controller.
///
/// This type is created by `@ControllerBuilder` when a builder block is empty.
/// It mirrors `EmptyView` but for controllers.
@MainActor
struct EmptyController: RepresentableController {
    init() {}
    
    func buildController(in context: BuildContext) -> UIViewController {
        UIViewController()
    }
    
    func buildControllerList(in context: BuildContext) -> [UIViewController] {
        []
    }
}

/// Make Optional conform to RepresentableController when wrapped type conforms.
extension Optional: RepresentableController where Wrapped: RepresentableController {
    func buildController(in context: BuildContext) -> UIViewController {
        switch self {
        case .some(let controller):
            return controller.buildController(in: context)
        case .none:
            return EmptyController().buildController(in: context)
        }
    }
    
    func buildControllerList(in context: BuildContext) -> [UIViewController] {
        switch self {
        case .some(let controller):
            return controller.buildControllerList(in: context)
        case .none:
            return []
        }
    }
}
