import UIKit
import DeclareKitCore

/// A reactive `UIImageView` component.
public struct ImageView: RepresentableNode {
    private let image: () -> UIImage?

    /// Creates an image view with a reactive image source.
    public init(_ image: @autoclosure @escaping () -> UIImage?) {
        self.image = image
    }

    /// Creates an image view from a reactive SF Symbol name.
    public init(systemName: @autoclosure @escaping () -> String) {
        self.image = { UIImage(systemName: systemName()) }
    }

    /// Creates an image view from a reactive asset name.
    public init(named: @autoclosure @escaping () -> String) {
        self.image = { UIImage(named: named()) }
    }

    /// Builds the configured `UIImageView`.
    public func build(in context: BuildContext) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        createEffect { [weak imageView] in
            guard let imageView else { return }
            imageView.image = self.image()
        }
        return imageView
    }
}

// MARK: - UIImageView modifiers

extension RepresentableNode where Representable == UIImageView {
    /// Sets the image view's `contentMode`.
    public func contentMode(_ mode: @autoclosure @escaping () -> UIView.ContentMode) -> Modifier<Self> {
        Modifier(self) { $0.contentMode = mode() }
    }

    /// Sets the image view's `tintColor` (useful for template-rendered SF Symbols).
    public func symbolColor(_ color: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { $0.tintColor = color() }
    }

    /// Sets the SF Symbol configuration.
    public func symbolConfiguration(_ configuration: @autoclosure @escaping () -> UIImage.SymbolConfiguration) -> Modifier<Self> {
        Modifier(self) { $0.preferredSymbolConfiguration = configuration() }
    }
}
