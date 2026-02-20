import UIKit
import DeclareKitCore

/// Renders a dynamic collection of views, reactively updating when the data changes.
///
/// Views are keyed by ID, so items that haven't changed are reused rather than rebuilt.
/// When the data changes, new items are added, removed items are torn down, and
/// reordered items are moved to their correct position.
///
/// ```swift
/// ForEach(items, id: \.id) { item in
///     Label(item.name)
/// }
///
/// // Identifiable shorthand
/// ForEach(items) { item in
///     Label(item.name)
/// }
/// ```
public struct ForEach<Data: RandomAccessCollection, ID: Hashable, Content: RepresentableNode>: RepresentableNode {
    public typealias Representable = UIView

    private let data: () -> Data
    private let id: (Data.Element) -> ID
    private let content: (Data.Element) -> Content

    public init(
        _ data: @autoclosure @escaping () -> Data,
        id: @escaping (Data.Element) -> ID,
        @NodeBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.id = id
        self.content = content
    }

    public func build(in context: BuildContext) {
        let anchor = UIView()
        anchor.isHidden = true
        anchor.translatesAutoresizingMaskIntoConstraints = false
        context.insertChild(anchor, nil)

        var orderedItems: [(id: ID, views: [UIView])] = []

        createEffect { [weak anchor] in
            guard let anchor, anchor.superview != nil else { return }

            let newData = self.data()
            let newIdSet = Set(newData.map { self.id($0) })

            // Remove views for deleted items
            for item in orderedItems where !newIdSet.contains(item.id) {
                item.views.forEach { $0.removeFromSuperview() }
            }

            // Build a lookup of surviving items
            let existingByID = Dictionary(
                uniqueKeysWithValues: orderedItems
                    .filter { newIdSet.contains($0.id) }
                    .map { ($0.id, $0.views) }
            )

            // Resolve the new ordered list — reuse existing views or capture new ones
            var newOrderedItems: [(id: ID, views: [UIView])] = []
            for element in newData {
                let elementID = self.id(element)
                if let existing = existingByID[elementID] {
                    newOrderedItems.append((id: elementID, views: existing))
                } else {
                    let views = context.capture(before: anchor) { ctx in
                        self.content(element).build(in: ctx)
                    }
                    newOrderedItems.append((id: elementID, views: views))
                }
            }

            // Re-insert all views in reverse order to establish the correct final order.
            // Iterating reversed and inserting each view before the previously placed view
            // correctly handles both new items and reordered existing ones in a single pass.
            var insertBefore: UIView = anchor
            for item in newOrderedItems.reversed() {
                for view in item.views.reversed() {
                    context.insertChild(view, insertBefore)
                    insertBefore = view
                }
            }

            orderedItems = newOrderedItems
        }
    }
}

// MARK: - Identifiable convenience

extension ForEach where Data.Element: Identifiable, ID == Data.Element.ID {
    public init(
        _ data: @autoclosure @escaping () -> Data,
        @NodeBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.init(data(), id: \.id, content: content)
    }
}

#Preview {
    ViewController {
        Stack(.vertical) {
            ForEach(0..<10, id: \.self) { i in
                Label("This is the label: \(i)")
            }
        }
    }
    .buildController()
}
