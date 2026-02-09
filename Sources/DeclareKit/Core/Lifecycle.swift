import UIKit

@MainActor
final class LifecycleCallbacks {
    var viewDidLoad: (() -> Void)?
    var viewWillAppear: ((Bool) -> Void)?
    var viewDidAppear: ((Bool) -> Void)?
    var viewWillDisappear: ((Bool) -> Void)?
    var viewDidDisappear: ((Bool) -> Void)?
}

@MainActor
protocol LifecycleRegistrable: AnyObject {
    var lifecycleCallbacks: LifecycleCallbacks { get }
}
