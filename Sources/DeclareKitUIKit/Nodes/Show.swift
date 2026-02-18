import UIKit
import DeclareKitCore


// MARK: - Show

/// Mounts or unmounts content based on a reactive condition.
///
/// Analogous to SolidJS `<Show>`. When `condition` is true, `content` is inserted
/// into the view hierarchy at the Show's position; when false, it is removed and
/// `fallback` (if provided) is inserted instead. Views are destroyed on hide and
/// rebuilt on show. Use `.isHidden` if you need to preserve view state across
/// visibility changes.
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

    public func build(in context: BuildContext) {
        let anchor = UIView()
        anchor.isHidden = true
        anchor.translatesAutoresizingMaskIntoConstraints = false
        context.insertChild(anchor, nil)

        let content = self.content
        let fallback = self.fallback
        let condition = self.condition

        var currentViews: [UIView] = []

        createEffect { [weak anchor] in
            guard let anchor, anchor.superview != nil else { return }

            currentViews.forEach { $0.removeFromSuperview() }

            if condition() {
                currentViews = context.capture(before: anchor) { content.build(in: $0) }
            } else {
                currentViews = context.capture(before: anchor) { fallback.build(in: $0) }
            }
        }
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
        .pin(to: .safeAreaLayoutGuide)
    }.buildController()
}
