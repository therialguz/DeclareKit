//
//  NavigationController.swift
//  DeclareKit
//
//  Created by Benjamín Guzmán López on 07-02-26.
//

import UIKit

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

    func buildController(in context: BuildContext) -> UIViewController {
        let rootViewController = content.buildController(in: context)
        return UINavigationController(rootViewController: rootViewController)
    }
}

/// A tab bar controller that manages multiple view controllers.
///
/// TabBarController takes RepresentableController content and displays them in a tab bar interface.
/// Each child controller should use view modifiers like `.tabItem(title:image:)` to configure its tab.
///
/// Example:
/// ```swift
/// TabBarController {
///     NavigationController {
///         Text("Home Content")
///     }
///     .tabItem(title: "Home", systemImage: "house")
///
///     ViewController {
///         Text("Settings Content")
///     }
///     .tabItem(title: "Settings", systemImage: "gear")
///     .tabBadge("3")
/// }
/// ```
struct TabBarController<Content: RepresentableController>: RepresentableController {
    private let content: Content

    init(@ControllerBuilder _ content: () -> Content) {
        self.content = content()
    }

    func buildController(in context: BuildContext) -> UIViewController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = content.buildControllerList(in: context)
        return tabBarController
    }
}

// MARK: - View Controller Modifiers

/// A modified view controller that applies a configuration closure.
private struct ModifiedController<Content: RepresentableController>: RepresentableController {
    private let content: Content
    private let modifier: (UIViewController) -> Void

    init(content: Content, modifier: @escaping (UIViewController) -> Void) {
        self.content = content
        self.modifier = modifier
    }

    func buildController(in context: BuildContext) -> UIViewController {
        let controller = content.buildController(in: context)
        modifier(controller)
        return controller
    }

    func buildControllerList(in context: BuildContext) -> [UIViewController] {
        let controllers = content.buildControllerList(in: context)
        controllers.forEach { modifier($0) }
        return controllers
    }
}

extension RepresentableController {
    func title(_ title: String) -> some RepresentableController {
        ModifiedController(content: self) { $0.title = title }
    }
    
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
    func tabItem(title: String) -> some RepresentableController {
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
    func tabItem(title: String, systemImage: String) -> some RepresentableController {
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
    func tabItem(title: String, image: UIImage?) -> some RepresentableController {
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
    func tabBadge(_ value: String?) -> some RepresentableController {
        ModifiedController(content: self) { vc in
            vc.tabBarItem?.badgeValue = value
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
    func tabBadgeColor(_ color: UIColor) -> some RepresentableController {
        ModifiedController(content: self) { vc in
            vc.tabBarItem?.badgeColor = color
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
    func tabAccessibilityLabel(_ label: String) -> some RepresentableController {
        ModifiedController(content: self) { vc in
            vc.tabBarItem?.accessibilityLabel = label
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
    func tabAccessibilityHint(_ hint: String) -> some RepresentableController {
        ModifiedController(content: self) { vc in
            vc.tabBarItem?.accessibilityHint = hint
        }
    }
}

#Preview {
    TabBarController {
        NavigationController {
            ViewController {
                Text("Home Content")
            }
            .title("Outer")
        }
        .tabItem(title: "Home", systemImage: "house")

        ViewController {
            Text("Settings Content")
        }
        .tabItem(title: "Settings", systemImage: "gear")
        .tabBadge("Chuta como estas, esto es tan bacan!!")
        
        CustomViewController()
    }
    .preview()
}

struct CustomViewController: RepresentableController {
    @State var count = 0

    @ControllerBuilder
    var body: some RepresentableController {
        NavigationController {
            ViewController {
                Stack(.vertical, spacing: 16, alignment: .center) {
                    Text("Count: \(self.count)")
                        .font(.systemFont(ofSize: 32, weight: .bold))
                        .textColor(self.count % 2 == 0 ? .systemBlue : .systemRed)

                    Button("Increment (\(self.count))") {
                        count += 1
                    }
                    .backgroundColor(self.count % 2 == 0 ? UIColor.systemGreen : UIColor.systemOrange)
                    .cornerRadius(8)

                    Show(when: self.count % 3 == 0) {
                        Text("You reached 3!")
                            .textColor(.systemGreen)
                            .font(.systemFont(ofSize: 18, weight: .medium))
                    }
                }
            }
            .title("Reactive Demo")
        }
        .tabItem(title: "Counter", systemImage: "plus")
    }

    func buildController(in context: BuildContext) -> UIViewController {
        body.buildController(in: context)
    }
}
