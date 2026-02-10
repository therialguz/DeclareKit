import UIKit

/// Storage for controller lifecycle callbacks used by lifecycle modifiers.
@MainActor
public final class LifecycleCallbacks {
    /// Called from `viewDidLoad()`.
    public var viewDidLoad: (() -> Void)?

    /// Called from `viewWillAppear(_:)`.
    public var viewWillAppear: ((Bool) -> Void)?

    /// Called from `viewDidAppear(_:)`.
    public var viewDidAppear: ((Bool) -> Void)?

    /// Called from `viewWillDisappear(_:)`.
    public var viewWillDisappear: ((Bool) -> Void)?

    /// Called from `viewDidDisappear(_:)`.
    public var viewDidDisappear: ((Bool) -> Void)?

    /// Creates an empty callback container.
    public init() {}
}

/// A controller that exposes lifecycle callback storage for modifiers.
@MainActor
public protocol LifecycleRegistrable: AnyObject {
    /// Mutable lifecycle callback storage used by modifier APIs.
    var lifecycleCallbacks: LifecycleCallbacks { get }
}
