import UIKit

@MainActor
public final class LifecycleCallbacks {
    public var viewDidLoad: (() -> Void)?
    public var viewWillAppear: ((Bool) -> Void)?
    public var viewDidAppear: ((Bool) -> Void)?
    public var viewWillDisappear: ((Bool) -> Void)?
    public var viewDidDisappear: ((Bool) -> Void)?

    public init() {}
}

@MainActor
public protocol LifecycleRegistrable: AnyObject {
    var lifecycleCallbacks: LifecycleCallbacks { get }
}
