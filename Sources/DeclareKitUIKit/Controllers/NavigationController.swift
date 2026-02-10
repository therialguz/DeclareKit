import UIKit

/// A navigation controller that wraps view content.
///
/// NavigationController takes RepresentableNode content (views) and wraps them
/// in a UINavigationController. Internally, it creates a HostViewController to
/// host the view content, which is then set as the root view controller.
public struct NavigationController<Content: RepresentableController>: RepresentableController {
    private let content: Content

    /// Creates a navigation controller with a root controller from `content`.
    public init(@ControllerBuilder _ content: () -> Content) {
        self.content = content()
    }

    /// Builds a `UINavigationController` with the composed root controller.
    public func buildController() -> UINavigationController {
        let rootViewController = content.buildController()
        return DKNavigationController(rootViewController: rootViewController)
    }
}

extension RepresentableController where Representable == UINavigationController {
    /// Sets whether the navigation bar prefers large titles.
    public func navigationBar(prefersLargeTitles: @autoclosure @escaping () -> Bool) -> ModifiedController<Self> {
        ModifiedController(content: self) { $0.navigationBar.prefersLargeTitles = prefersLargeTitles() }
    }
}

/// Internal `UINavigationController` subclass with lifecycle callback forwarding.
@MainActor
public final class DKNavigationController: UINavigationController, LifecycleRegistrable {
    /// Mutable lifecycle callback storage used by lifecycle modifiers.
    public let lifecycleCallbacks = LifecycleCallbacks()

    override public func viewDidLoad() {
        super.viewDidLoad()
        lifecycleCallbacks.viewDidLoad?()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lifecycleCallbacks.viewWillAppear?(animated)
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lifecycleCallbacks.viewDidAppear?(animated)
    }

    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lifecycleCallbacks.viewWillDisappear?(animated)
    }

    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        lifecycleCallbacks.viewDidDisappear?(animated)
    }
}

import SwiftUI
#Preview {
    NavigationController {
        ViewController {
            Label("Miau")
        }
        .title("Chuta")
    }
    .navigationItem(largeTitle: "Large Title")
    .navigationBar(prefersLargeTitles: true)
    .buildController()
}
