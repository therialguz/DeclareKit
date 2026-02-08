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
struct NavigationController<Content: RepresentableNode>: RepresentableController {
    private let content: Content

    init(@NodeBuilder _ content: () -> Content) {
        self.content = content()
    }

    func buildController(in context: BuildContext) -> UIViewController {
        // Create a host view controller to contain the view content
        let hostVC = HostViewController(content: content)
        return UINavigationController(rootViewController: hostVC)
    }
}

/// A tab in a tab bar controller.
///
/// Tab represents a single tab and takes a RepresentableController as its content.
/// For view-only tabs, wrap content in `ViewController { ... }`.
struct Tab<Content: RepresentableController>: RepresentableController {
    private let title: String
    private let image: UIImage?
    private let content: Content

    init(_ title: String, systemImage: String, @ControllerBuilder _ content: () -> Content) {
        self.title = title
        self.image = UIImage(systemName: systemImage)
        self.content = content()
    }

    init(_ title: String, image: UIImage? = nil, @ControllerBuilder _ content: () -> Content) {
        self.title = title
        self.image = image
        self.content = content()
    }

    func buildController(in context: BuildContext) -> UIViewController {
        let vc = content.buildController(in: context)
        vc.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: nil)
        return vc
    }
}

/// A tab bar controller that manages multiple tabs.
///
/// TabController takes RepresentableController content (controllers) and displays
/// them in a tab bar interface. Each child must conform to RepresentableController.
struct TabController<Content: RepresentableController>: RepresentableController {
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

extension RepresentableNode {
    /// Sets the navigation title for this view.
    ///
    /// This modifier updates the navigation item title of the parent view controller.
    func navigationTitle(_ title: String) -> Modifier<Self> {
        Modifier(self, { _, context in context.parentViewController.navigationItem.title = title })
    }
}

#Preview {
    TabController {
        Tab("Home", systemImage: "house") {
            NavigationController {
                Text("Home Content")
                    .navigationTitle("Home")
            }
        }

        Tab("Settings", systemImage: "gear") {
            ViewController {
                Text("Settings Content")
            }
        }
    }
    .preview()
}
