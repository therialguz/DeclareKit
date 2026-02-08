import UIKit

/// A type that can be represented as a UIViewController in the hierarchy.
///
/// This protocol mirrors RepresentableNode but for view controllers instead of views.
/// Types conforming to this protocol can build UIViewController instances and participate
/// in controller-based hierarchies like tab bars and navigation stacks.
@MainActor
protocol RepresentableController {
    /// Builds and returns a single UIViewController representing this controller node.
    func buildController(in context: BuildContext) -> UIViewController

    /// Builds and returns an array of UIViewControllers.
    ///
    /// Most types return a single controller. Types like _TupleController return multiple.
    func buildControllerList(in context: BuildContext) -> [UIViewController]
}

extension RepresentableController {
    /// Default implementation returns a single controller in an array.
    func buildControllerList(in context: BuildContext) -> [UIViewController] {
        [buildController(in: context)]
    }

    /// Creates a preview UIViewController for Xcode previews.
    ///
    /// Example:
    /// ```swift
    /// #Preview {
    ///     TabBarController {
    ///         NavigationController { HomeView() }
    ///             .tabItem(title: "Home", systemImage: "house")
    ///     }
    ///     .preview()
    /// }
    /// ```
    func preview() -> UIViewController {
        buildController(in: BuildContext())
    }
}
