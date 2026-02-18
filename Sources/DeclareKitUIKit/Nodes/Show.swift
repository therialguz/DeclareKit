import UIKit
import DeclareKitCore

// MARK: - _ShowAnchor

/// A permanently-mounted hidden view that holds Show's positional slot in its parent.
///
/// Fires `onMount` once after being inserted into a superview, which is the safe
/// point to start reactive effects (the anchor is in the hierarchy at that moment).
private final class _ShowAnchor: UIView {
    var onMount: (() -> Void)?

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard superview != nil else { return }
        onMount?()
        onMount = nil
    }
}

// MARK: - Show

/// Mounts or unmounts content based on a reactive condition.
///
/// Analogous to SolidJS `<Show>`. When `condition` is true, `content` is inserted
/// into the view hierarchy at the Show's position; when false, it is removed and
/// `fallback` (if provided) is inserted instead. Views are **cached** after the
/// first build and reused across condition changes.
///
/// ```swift
/// Show(when: isLoggedIn) {
///     Label("Welcome!")
/// } fallback: {
///     Label("Please log in")
/// }
/// ```
public struct Show<Content: RepresentableNode, Fallback: RepresentableNode>: RepresentableNode {
    private let condition: () -> Bool
    private let content: Content
    private let fallback: Fallback

    /// Creates a Show node with content and fallback.
    public init(
        when condition: @autoclosure @escaping () -> Bool,
        @NodeBuilder _ content: () -> Content,
        @NodeBuilder fallback: () -> Fallback
    ) {
        self.condition = condition
        self.content = content()
        self.fallback = fallback()
    }

    public func build(in context: BuildContext) -> UIView {
        let anchor = _ShowAnchor()
        anchor.isHidden = true
        anchor.translatesAutoresizingMaskIntoConstraints = false

        let insertChild = context.insertChild
        let content = self.content
        let fallback = self.fallback
        let condition = self.condition

        var contentViews: [UIView]? = nil
        var fallbackViews: [UIView]? = nil

        anchor.onMount = {
            createEffect { [weak anchor] in
                guard anchor?.superview != nil else { return }

                if condition() {
                    fallbackViews?.forEach { $0.removeFromSuperview() }
                    if contentViews == nil {
                        contentViews = content.buildList(in: context)
                    }
                    contentViews?.forEach { insertChild($0, anchor) }
                } else {
                    contentViews?.forEach { $0.removeFromSuperview() }
                    if fallbackViews == nil {
                        fallbackViews = fallback.buildList(in: context)
                    }
                    fallbackViews?.forEach { insertChild($0, anchor) }
                }
            }
        }

        return anchor
    }
}

// MARK: - No-fallback convenience

extension Show where Fallback == EmptyView {
    /// Creates a Show node with content only (no fallback).
    public init(
        when condition: @autoclosure @escaping () -> Bool,
        @NodeBuilder _ content: () -> Content
    ) {
        self.condition = condition
        self.content = content()
        self.fallback = EmptyView()
    }
}

// MARK: - Preview

#Preview {
    ViewController {
        @Signal var visible: Bool = true
        
        Stack(.vertical, spacing: 16) {
            Show(when: visible) {
                Label("Content is visible")
                    .backgroundColor(.systemGreen)
            } fallback: {
                Label("Fallback is visible")
                    .backgroundColor(.systemOrange)
            }
            Button("Toggle") { visible.toggle() }
        }
    }.buildController()
}
