import UIKit
import DeclareKitCore

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
public struct TabBarController<Content: RepresentableController>: RepresentableController {
    private let content: Content

    /// Creates a tab bar controller from a controller builder block.
    public init(@ControllerBuilder _ content: () -> Content) {
        self.content = content()
    }

    /// Builds a `UITabBarController` with all child controllers.
    public func buildController() -> UITabBarController {
        let tabBarController = DKTabBarController()
        tabBarController.viewControllers = content.buildControllerList()
        return tabBarController
    }
}

extension RepresentableController where Representable == UITabBarController {
    public func tabBarMinimizeBehavior(_ tabBarMinimizeBehavior: @autoclosure @escaping () -> UITabBarController.MinimizeBehavior) -> ModifiedController<Self> {
        ModifiedController(content: self) { $0.tabBarMinimizeBehavior = tabBarMinimizeBehavior() }
    }
    
    public func bottomAccessory(_ bottomAccessory: @autoclosure @escaping () -> UITabAccessory) -> ModifiedController<Self> {
        ModifiedController(content: self) { $0.bottomAccessory = bottomAccessory() }
    }
    
    public func mode(_ mode: @autoclosure @escaping () -> UITabBarController.Mode) -> ModifiedController<Self> {
        ModifiedController(content: self) { $0.mode = mode() }
    }
    
    public func sidebar(isHidden: @autoclosure @escaping () -> Bool ) -> ModifiedController<Self> {
        ModifiedController(content: self) { $0.sidebar.isHidden = isHidden() }
    }
}

/// Internal `UITabBarController` subclass with lifecycle callback forwarding.
@MainActor
public final class DKTabBarController: UITabBarController, LifecycleRegistrable {
    /// Mutable lifecycle callback storage used by lifecycle modifiers.
    public let lifecycleCallbacks = LifecycleCallbacks()

    override public func viewDidLoad() {
        super.viewDidLoad()
        lifecycleCallbacks.viewDidLoad?()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lifecycleCallbacks.viewWillAppear?(animated)
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lifecycleCallbacks.viewDidAppear?(animated)
    }

    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lifecycleCallbacks.viewWillDisappear?(animated)
    }

    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        lifecycleCallbacks.viewDidDisappear?(animated)
    }
}

/// Preview-only counter component used in local examples.
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

/// Preview-only screen used to demonstrate tab and lifecycle modifiers.
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
            ViewController {
                ScrollView {
                    Stack(.vertical) {
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                        Label("Chuta")
                    }
                }
            }
        }
        .tabBarItem(title: "Settings", systemImage: "gearshape.fill")
        .tabBarItem(badge: "4")

        NavigationController {

        }
        .tabBarItem(title:  "Tab 3")
        
        NavigationController {

        }
        .tabBarItem(title:  "Tab 4")
        
        NavigationController {

        }
        .tabBarItem(UITabBarItem(tabBarSystemItem: .search, tag: 0))
    }
    .tabBarMinimizeBehavior(.onScrollDown)
    .bottomAccessory(.init(contentView: Label("This is the accessory").build()))
    .mode(.tabSidebar)
    .sidebar(isHidden: true)
    .buildController()
}

