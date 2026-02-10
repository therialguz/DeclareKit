import UIKit

/// Internal type representing conditional controller branches (if-else).
///
/// This type is created by `@ControllerBuilder` when using `if-else` statements.
/// It mirrors `_ConditionalNode` but for controllers.
@MainActor
public enum _ConditionalController<
    TrueController: RepresentableController, FalseController: RepresentableController
>: RepresentableController {
    case first(TrueController)
    case second(FalseController)

    public func buildController() -> UIViewController {
        switch self {
        case .first(let controller):
            return controller.buildController()
        case .second(let controller):
            return controller.buildController()
        }
    }

    public func buildControllerList() -> [UIViewController] {
        switch self {
        case .first(let controller):
            return controller.buildControllerList()
        case .second(let controller):
            return controller.buildControllerList()
        }
    }
}
