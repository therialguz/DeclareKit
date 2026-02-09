import UIKit
#if canImport(SwiftUI)
import SwiftUI
#endif

/// A navigation controller that wraps view content.
///
/// NavigationController takes RepresentableNode content (views) and wraps them
/// in a UINavigationController. Internally, it creates a HostViewController to
/// host the view content, which is then set as the root view controller.
struct NavigationController<Content: RepresentableController>: RepresentableController {
    private let content: Content

    init(@ControllerBuilder _ content: () -> Content) {
        self.content = content()
    }

    func buildController() -> UIViewController {
        let rootViewController = content.buildController()
        return DKNavigationController(rootViewController: rootViewController)
    }
}

@MainActor
final class DKNavigationController: UINavigationController, LifecycleRegistrable {
    let lifecycleCallbacks = LifecycleCallbacks()

    override func viewDidLoad() {
        super.viewDidLoad()
        lifecycleCallbacks.viewDidLoad?()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lifecycleCallbacks.viewWillAppear?(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lifecycleCallbacks.viewDidAppear?(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lifecycleCallbacks.viewWillDisappear?(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        lifecycleCallbacks.viewDidDisappear?(animated)
    }
}

#Preview {
    NavigationController {
        ViewController {
            Label("Miau")
        }
    }
    .buildController()
}
