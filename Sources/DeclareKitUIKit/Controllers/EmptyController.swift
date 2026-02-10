import UIKit

/// A controller that represents an empty controller.
///
/// This type is created by `@ControllerBuilder` when a builder block is empty.
/// It mirrors `EmptyView` but for controllers.
@MainActor
public struct EmptyController: RepresentableController {
    /// Creates an empty controller value.
    public init() {}

    /// Builds an empty placeholder view controller.
    public func buildController() -> UIViewController {
        UIViewController()
    }

    /// Builds no controllers, useful in builder flattening.
    public func buildControllerList() -> [UIViewController] {
        []
    }
}

/// Make Optional conform to RepresentableController when wrapped type conforms.
extension Optional: RepresentableController where Wrapped: RepresentableController {
    /// Builds the wrapped controller or an empty fallback when `nil`.
    public func buildController() -> UIViewController {
        switch self {
        case .some(let controller):
            return controller.buildController()
        case .none:
            return EmptyController().buildController()
        }
    }

    /// Builds the wrapped controller list or an empty list when `nil`.
    public func buildControllerList() -> [UIViewController] {
        switch self {
        case .some(let controller):
            return controller.buildControllerList()
        case .none:
            return []
        }
    }
}
