import UIKit

// MARK: - View Controller Modifiers

/// A modified view controller that applies a configuration closure.
private struct ModifiedController<Content: RepresentableController>: RepresentableController {
    private let content: Content
    private let modifier: (UIViewController) -> Void

    init(content: Content, modifier: @escaping (UIViewController) -> Void) {
        self.content = content
        self.modifier = modifier
    }

    func buildController() -> UIViewController {
        let controller = content.buildController()
        modifier(controller)
        return controller
    }

    func buildControllerList() -> [UIViewController] {
        let controllers = content.buildControllerList()
        controllers.forEach { modifier($0) }
        return controllers
    }
}

extension RepresentableController {
    func title(_ title: String) -> some RepresentableController {
        ModifiedController(content: self) { $0.title = title }
    }
}

extension RepresentableController {

    func tabBarItem(_ tabBarItem: UITabBarItem) -> some RepresentableController {
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
    func tabBarItem(title: String) -> some RepresentableController {
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
    func tabBarItem(title: String, systemImage: String) -> some RepresentableController {
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
    func tabBarItem(title: String, image: UIImage?) -> some RepresentableController {
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
    func tabBarItem(badge: String?) -> some RepresentableController {
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
    func tabBarItem(badgeColor: UIColor) -> some RepresentableController {
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
    func tabBarItem(accessibilityLabel: String) -> some RepresentableController {
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
    func tabBarItem(accessibilityHint: String) -> some RepresentableController {
        ModifiedController(content: self) { vc in
            vc.tabBarItem?.accessibilityHint = accessibilityHint
        }
    }
}
