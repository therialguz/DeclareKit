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

import SwiftUI

struct Counter: Component {
    @Binding var count: Int
    
    var body: some RepresentableNode {
        Button("Increase Count (\(count))", action: {
            withAnimation {
                count += 1
            }
            print("Increasing count from button: \(count)")
        })
    }
}

struct CounterViewScreen: Screen {
    @Signal var count: Int = 5
    
    var body: some RepresentableController {
        ViewController {
            SafeAreaView {
                Stack(.vertical) {
                    Counter(count: $count)
                        .backgroundColor(count % 2 == 0 ? .green : .yellow)
//                        .with { view in
//                            UIView.animate(.default) {
//                                view.layer.cornerRadius = count % 2 == 0 ? 10 : view.frame.width / 2
//                                view.backgroundColor = count % 3 == 0 ? .green : .yellow
//                            }
//                        }
                }
                .backgroundColor(.blue)
            }
            .backgroundColor(.red)
        }
        .title("Counter (\(count))")
    }
}

#Preview {
    TabBarController {
        NavigationController {
            CounterViewScreen()
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
