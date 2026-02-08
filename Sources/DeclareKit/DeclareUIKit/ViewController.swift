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
    
    func buildController(in context: BuildContext) -> UIViewController {
        HostViewController(content: content)
    }
}

/// Internal UIViewController that hosts RepresentableNode content.
@MainActor
final class HostViewController<Content: RepresentableNode>: UIViewController {
    private let content: () -> Content
    
    init(content: @escaping () -> Content) {
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let views = content().buildList()
        for child in views {
            self.view.addSubview(child)
            NSLayoutConstraint.activate([
                child.topAnchor.constraint(equalTo: self.view.topAnchor),
                child.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                child.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                child.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        }
    }
}
