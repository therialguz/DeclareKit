import UIKit

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

    func buildController() -> UIViewController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = content.buildControllerList()
        return tabBarController
    }
}

#Preview {
    TabBarController {
        NavigationController {
            
        }
        .tabBarItem(title: "Home", systemImage: "house.fill")
        
        NavigationController {
            
        }
        .tabBarItem(title: "Settings", systemImage: "gearshape.fill")
        .tabBarItem(badge: "4")
        
        NavigationController {
            
        }
        .tabBarItem(UITabBarItem(tabBarSystemItem: .search, tag: 0))
    }
    .buildController()
}
