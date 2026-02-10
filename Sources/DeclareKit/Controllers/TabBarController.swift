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
        let tabBarController = DKTabBarController()
        tabBarController.viewControllers = content.buildControllerList()
        return tabBarController
    }
}

@MainActor
final class DKTabBarController: UITabBarController, LifecycleRegistrable {
    let lifecycleCallbacks = LifecycleCallbacks()

    override func viewDidLoad() {
        super.viewDidLoad()
        lifecycleCallbacks.viewDidLoad?()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lifecycleCallbacks.viewWillAppear?(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lifecycleCallbacks.viewDidAppear?(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lifecycleCallbacks.viewWillDisappear?(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        lifecycleCallbacks.viewDidDisappear?(animated)
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
//                Stack(.vertical) {
                    Counter(count: $count)
                        .backgroundColor(count % 2 == 0 ? .green : .yellow)
                        .layer(cornerRadius: count % 2 == 0 ? 40 : 400)
                        .layer(shadowColor: .black)
                        .layer(shadowRadius: 20)
                        .layer(shadowOpacity: 1)
                        .layer(opacity: count % 2 == 0 ? 0.25 : 1)
//                }
//                .backgroundColor(.blue)
            }
            .backgroundColor(.red)
        }
        .title("Counter (\(count))")
        .viewDidLoad({ print("viewDidLoad") })
        .viewWillAppear({ print("viewWillAppear") })
        .viewDidAppear({ print("viewDidAppear") })
        .viewWillDisappear({ print("viewWillAppear") })
        .viewDidDisappear({ print("viewDidDisappear") })
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
