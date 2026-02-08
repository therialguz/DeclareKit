//
//  Show.swift
//  DeclareKit
//
//  Created by Claude on 08-02-26.
//

import UIKit

/// Reactive conditional rendering — analogous to SolidJS `<Show>`.
///
/// Shows or hides content based on a reactive boolean condition.
/// The container UIView acts as a stable anchor in the parent layout.
/// Content is lazily built only when the condition first becomes true.
///
/// ```swift
/// Show(when: model.isLoggedIn) {
///     Text("Welcome!")
/// }
/// ```
struct Show<Content: RepresentableNode>: RepresentableNode {
    private let condition: () -> Bool
    private let content: () -> Content

    init(when condition: @autoclosure @escaping () -> Bool, @NodeBuilder _ content: @escaping () -> Content) {
        self.condition = condition
        self.content = content
    }

    func build() -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        var childView: UIView?

        createEffect { [weak container] in
            guard let container else { return }
            let show = self.condition()

            if show {
                if childView == nil {
                    let built = self.content().build()
                    built.translatesAutoresizingMaskIntoConstraints = false
                    container.addSubview(built)
                    NSLayoutConstraint.activate([
                        built.topAnchor.constraint(equalTo: container.topAnchor),
                        built.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                        built.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                        built.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                    ])
                    childView = built
                } else {
                    childView?.isHidden = false
                }
            } else {
                childView?.isHidden = true
            }
        }

        return container
    }
}
