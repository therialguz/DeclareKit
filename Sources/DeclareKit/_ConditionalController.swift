import UIKit

/// Internal type representing conditional controller branches (if-else).
///
/// This type is created by `@ControllerBuilder` when using `if-else` statements.
/// It mirrors `_ConditionalNode` but for controllers.
@MainActor
enum _ConditionalController<
    TrueController: RepresentableController, FalseController: RepresentableController
>: RepresentableController {
    case first(TrueController)
    case second(FalseController)

    func buildController(in context: BuildContext) -> UIViewController {
        switch self {
        case .first(let controller):
            return controller.buildController(in: context)
        case .second(let controller):
            return controller.buildController(in: context)
        }
    }

    func buildControllerList(in context: BuildContext) -> [UIViewController] {
        switch self {
        case .first(let controller):
            return controller.buildControllerList(in: context)
        case .second(let controller):
            return controller.buildControllerList(in: context)
        }
    }
}
