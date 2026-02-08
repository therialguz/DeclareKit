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
        HostViewController(content: content())
    }
}

/// Internal UIViewController that hosts RepresentableNode content.
@MainActor
final class HostViewController<Content: RepresentableNode>: UIViewController {
    private let content: Content
    
    init(content: Content) {
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = BuildContext(parentViewController: self)
        let views = content.buildList(in: context)
        
        // If single view, add it directly
        if views.count == 1, let singleView = views.first {
            view.addSubview(singleView)
            NSLayoutConstraint.activate([
                singleView.topAnchor.constraint(equalTo: view.topAnchor),
                singleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                singleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                singleView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        } else {
            // Multiple views: stack them vertically
            let stackView = UIStackView(arrangedSubviews: views)
            stackView.axis = .vertical
            stackView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(stackView)
            
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: view.topAnchor),
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
}
