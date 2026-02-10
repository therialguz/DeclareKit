import UIKit

/// Describes how a reactive property change should be animated.
public struct Animation: Sendable {
    public let duration: TimeInterval
    public let delay: TimeInterval
    public let options: UIView.AnimationOptions
    public let springDamping: CGFloat?
    public let springVelocity: CGFloat?

    private init(
        duration: TimeInterval,
        delay: TimeInterval = 0,
        options: UIView.AnimationOptions = [],
        springDamping: CGFloat? = nil,
        springVelocity: CGFloat? = nil
    ) {
        self.duration = duration
        self.delay = delay
        self.options = options
        self.springDamping = springDamping
        self.springVelocity = springVelocity
    }

    // MARK: - Presets

    public static let `default` = Animation.easeInOut()

    public static func easeInOut(duration: TimeInterval = 0.3) -> Animation {
        Animation(duration: duration, options: .curveEaseInOut)
    }

    public static func easeIn(duration: TimeInterval = 0.3) -> Animation {
        Animation(duration: duration, options: .curveEaseIn)
    }

    public static func easeOut(duration: TimeInterval = 0.3) -> Animation {
        Animation(duration: duration, options: .curveEaseOut)
    }

    public static func linear(duration: TimeInterval = 0.3) -> Animation {
        Animation(duration: duration, options: .curveLinear)
    }

    public static func spring(
        duration: TimeInterval = 0.5,
        damping: CGFloat = 0.7,
        velocity: CGFloat = 0.5
    ) -> Animation {
        Animation(duration: duration, springDamping: damping, springVelocity: velocity)
    }

    // MARK: - Execution

    @MainActor
    public func perform(_ animations: @escaping () -> Void) {
        if let damping = springDamping, let velocity = springVelocity {
            UIView.animate(
                withDuration: duration,
                delay: delay,
                usingSpringWithDamping: damping,
                initialSpringVelocity: velocity,
                options: options,
                animations: animations
            )
        } else {
            UIView.animate(
                withDuration: duration,
                delay: delay,
                options: options,
                animations: animations
            )
        }
    }
}

// MARK: - Animation context

@MainActor
public enum AnimationContext {
    public static var current: Animation?
}

/// Wraps state mutations so that all reactive effects triggered by those
/// mutations animate their UIView property changes.
///
/// ```swift
/// Button("Toggle", action: {
///     withAnimation(.easeInOut()) {
///         isExpanded.toggle()
///     }
/// })
/// ```
///
/// **How it works:** Sets a global animation context before running `body`.
/// When `@Observable` properties change inside `body`, each observing
/// `createEffect` is re-scheduled via `Task { @MainActor in … }`. Those
/// tasks run after `body` returns but while the context is still set.
/// A final cleanup task (enqueued after the mutation tasks) clears it.
@MainActor
public func withAnimation(_ animation: Animation = .default, _ body: () -> Void) {
    AnimationContext.current = animation
    body()
    Task { @MainActor in
        AnimationContext.current = nil
    }
}
