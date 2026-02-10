import UIKit
import DeclareKitCore

// MARK: - View Controller Modifiers

/// A modified view controller that applies a configuration closure.
public struct ModifiedController<Content: RepresentableController>: RepresentableController {
    private let content: Content
    private let modifier: (Content.Representable) -> Void
    private let reactive: Bool

    public init(
        content: Content,
        reactive: Bool = true,
        modifier: @escaping (Content.Representable) -> Void
    ) {
        self.content = content
        self.modifier = modifier
        self.reactive = reactive
    }

    public func buildController() -> Content.Representable {
        let controller = content.buildController()

        if reactive {
            createEffect { [weak controller] in
                guard let controller else { return }
                if let animation = AnimationContext.current {
                    animation.perform {
                        self.modifier(controller)
                    }
                } else {
                    self.modifier(controller)
                }
            }
        } else {
            modifier(controller)
        }

        return controller
    }
}

extension RepresentableController {
    public func title(_ title: @autoclosure @escaping () -> String) -> ModifiedController<Self> {
        ModifiedController(content: self) { $0.title = title() }
    }

    public func navigationItem(title: @autoclosure @escaping () -> String) -> ModifiedController<Self> {
        ModifiedController(content: self) { $0.navigationItem.title = title() }
    }

    public func navigationItem(largeTitleDisplayMode: @autoclosure @escaping () -> UINavigationItem.LargeTitleDisplayMode) -> ModifiedController<Self> {
        ModifiedController(content: self) { $0.navigationItem.largeTitleDisplayMode = .always }
    }

    public func navigationItem(largeTitle: @autoclosure @escaping () -> String) -> ModifiedController<Self> {
        ModifiedController(content: self) { $0.navigationItem.largeTitle = largeTitle() }
    }
}

extension RepresentableController {

    public func tabBarItem(_ tabBarItem: UITabBarItem) -> ModifiedController<Self> {
        ModifiedController(content: self, modifier: { $0.tabBarItem = tabBarItem })
    }

    /// Sets the tab bar item title only.
    ///
    /// Use this modifier on view controllers that will be displayed in a TabBarController.
    ///
    /// Example:
    /// ```swift
    /// ViewController { ... }
    ///     .tabItem(title: "Settings")
    /// ```
    public func tabBarItem(title: String) -> ModifiedController<Self> {
        ModifiedController(content: self) { vc in
            vc.tabBarItem.title = title
        }
    }

    /// Sets the tab bar item with a title and system image.
    ///
    /// Use this modifier on view controllers that will be displayed in a TabBarController.
    ///
    /// Example:
    /// ```swift
    /// NavigationController { ... }
    ///     .tabItem(title: "Home", systemImage: "house")
    /// ```
    public func tabBarItem(title: String, systemImage: String) -> ModifiedController<Self> {
        ModifiedController(content: self) { vc in
            vc.tabBarItem.title = title
            vc.tabBarItem.image = UIImage(systemName: systemImage)
        }
    }

    /// Sets the tab bar item with a title and custom image.
    ///
    /// Use this modifier on view controllers that will be displayed in a TabBarController.
    ///
    /// Example:
    /// ```swift
    /// ViewController { ... }
    ///     .tabItem(title: "Profile", image: myCustomImage)
    /// ```
    public func tabBarItem(title: String, image: UIImage?) -> ModifiedController<Self> {
        ModifiedController(content: self) { vc in
            vc.tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
        }
    }

    /// Sets the tab bar item badge value.
    ///
    /// The badge appears as a red circle with the specified text on the tab bar item.
    ///
    /// Example:
    /// ```swift
    /// ViewController { ... }
    ///     .tabItem(title: "Messages", systemImage: "message")
    ///     .tabBadge("5")
    /// ```
    public func tabBarItem(badge: String?) -> ModifiedController<Self> {
        ModifiedController(content: self) { vc in
            vc.tabBarItem?.badgeValue = badge
        }
    }

    /// Sets the tab bar item badge color (iOS 10+).
    ///
    /// Example:
    /// ```swift
    /// ViewController { ... }
    ///     .tabItem(title: "Notifications", systemImage: "bell")
    ///     .tabBadge("3")
    ///     .tabBadgeColor(.systemBlue)
    /// ```
    public func tabBarItem(badgeColor: UIColor) -> ModifiedController<Self> {
        ModifiedController(content: self) { vc in
            vc.tabBarItem?.badgeColor = badgeColor
        }
    }

    /// Sets the accessibility label for the tab bar item.
    ///
    /// Example:
    /// ```swift
    /// ViewController { ... }
    ///     .tabItem(title: "Settings", systemImage: "gear")
    ///     .tabAccessibilityLabel("Settings Tab")
    /// ```
    public func tabBarItem(accessibilityLabel: String) -> ModifiedController<Self> {
        ModifiedController(content: self) { vc in
            vc.tabBarItem?.accessibilityLabel = accessibilityLabel
        }
    }

    /// Sets the accessibility hint for the tab bar item.
    ///
    /// Example:
    /// ```swift
    /// ViewController { ... }
    ///     .tabItem(title: "Profile", systemImage: "person")
    ///     .tabAccessibilityHint("Double tap to view your profile")
    /// ```
    public func tabBarItem(accessibilityHint: String) -> ModifiedController<Self> {
        ModifiedController(content: self) { vc in
            vc.tabBarItem?.accessibilityHint = accessibilityHint
        }
    }
}

// MARK: - Lifecycle Modifiers

extension RepresentableController {
    public func viewDidLoad(_ callback: @escaping () -> Void) -> ModifiedController<Self> {
        ModifiedController(content: self, reactive: false) { controller in
            (controller as? LifecycleRegistrable)?.lifecycleCallbacks.viewDidLoad = callback
        }
    }

    public func viewWillAppear(_ callback: @escaping (_ animated: Bool) -> Void) -> ModifiedController<Self> {
        ModifiedController(content: self, reactive: false) { controller in
            (controller as? LifecycleRegistrable)?.lifecycleCallbacks.viewWillAppear = callback
        }
    }

    public func viewWillAppear(_ callback: @escaping () -> Void) -> ModifiedController<Self> {
        ModifiedController(content: self, reactive: false) { controller in
            (controller as? LifecycleRegistrable)?.lifecycleCallbacks.viewWillAppear = { _ in callback() }
        }
    }

    public func viewDidAppear(_ callback: @escaping (_ animated: Bool) -> Void) -> ModifiedController<Self> {
        ModifiedController(content: self, reactive: false) { controller in
            (controller as? LifecycleRegistrable)?.lifecycleCallbacks.viewDidAppear = callback
        }
    }

    public func viewDidAppear(_ callback: @escaping () -> Void) -> ModifiedController<Self> {
        ModifiedController(content: self, reactive: false) { controller in
            (controller as? LifecycleRegistrable)?.lifecycleCallbacks.viewDidAppear = { _ in callback() }
        }
    }

    public func viewWillDisappear(_ callback: @escaping (_ animated: Bool) -> Void) -> ModifiedController<Self> {
        ModifiedController(content: self, reactive: false) { controller in
            (controller as? LifecycleRegistrable)?.lifecycleCallbacks.viewWillDisappear = callback
        }
    }

    public func viewWillDisappear(_ callback: @escaping () -> Void) -> ModifiedController<Self> {
        ModifiedController(content: self, reactive: false) { controller in
            (controller as? LifecycleRegistrable)?.lifecycleCallbacks.viewWillDisappear = { _ in callback() }
        }
    }

    public func viewDidDisappear(_ callback: @escaping (_ animated: Bool) -> Void) -> ModifiedController<Self> {
        ModifiedController(content: self, reactive: false) { controller in
            (controller as? LifecycleRegistrable)?.lifecycleCallbacks.viewDidDisappear = callback
        }
    }

    public func viewDidDisappear(_ callback: @escaping () -> Void) -> ModifiedController<Self> {
        ModifiedController(content: self, reactive: false) { controller in
            (controller as? LifecycleRegistrable)?.lifecycleCallbacks.viewDidDisappear = { _ in callback() }
        }
    }
}
