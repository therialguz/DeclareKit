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
public struct ViewController<Content: RepresentableNode>: RepresentableController {
    private let content: () -> Content

    /// Creates a view controller that hosts the given view content.
    public init(@NodeBuilder _ content: @escaping () -> Content) {
        self.content = content
    }

    /// Builds a host controller for the declared view content.
    public func buildController() -> UIViewController {
        HostViewController(content: content)
    }
}

/// Internal UIViewController that hosts RepresentableNode content.
@MainActor
public final class HostViewController<Content: RepresentableNode>: UIViewController, LifecycleRegistrable {
    private let content: () -> Content

    /// Mutable lifecycle callback storage used by lifecycle modifiers.
    public let lifecycleCallbacks = LifecycleCallbacks()

    /// Creates a host controller wrapping the provided content closure.
    public init(content: @escaping () -> Content) {
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func loadView() {
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
