import UIKit

/// A controller that wraps RepresentableNode content in a UIViewController.
///
/// This is the explicit bridge type that converts views into a view controller.
/// Use this when you need to provide view content where a controller is expected.
///
/// Example:
/// ```swift
/// Tab("Settings") {
///     ViewController {
///         Text("Settings Content")
///     }
/// }
/// ```
@MainActor
struct ViewController<Content: RepresentableNode>: RepresentableController {
    private let content: () -> Content
    
    /// Creates a view controller that hosts the given view content.
    init(@NodeBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
    
    func buildController() -> UIViewController {
        HostViewController(content: content)
    }
}

/// Internal UIViewController that hosts RepresentableNode content.
@MainActor
final class HostViewController<Content: RepresentableNode>: UIViewController, LifecycleRegistrable {
    private let content: () -> Content
    let lifecycleCallbacks = LifecycleCallbacks()

    init(content: @escaping () -> Content) {
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        let views = content().buildList()
        for child in views {
            view.addSubview(child)
            NSLayoutConstraint.activate([
                child.topAnchor.constraint(equalTo: view.topAnchor),
                child.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                child.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                child.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        }
    }

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
