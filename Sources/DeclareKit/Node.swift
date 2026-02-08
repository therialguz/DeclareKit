//
//  Node.swift
//  GHFollowers
//
//  Created by Benjamín Guzmán López on 06-02-26.
//

import Foundation
import SwiftUI
import UIKit

@MainActor
protocol RepresentableNode {
    associatedtype Representable: UIView

    func build() -> Representable

    func buildList() -> [UIView]
}

extension RepresentableNode {
    func buildList() -> [UIView] {
        [build()]
    }
}

//extension RepresentableNode {
//    func preview() -> HostViewController<Self> {
//        HostViewController(host: self)
//    }
//}

struct Text: RepresentableNode {
    private let text: () -> String

    init(_ text: @autoclosure @escaping () -> String) {
        self.text = text
    }

    func build() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        createEffect { [weak label] in
            guard let label else { return }
            label.text = self.text()
        }
        return label
    }
}

extension RepresentableNode {
    //    func with(_ closure: @MainActor @escaping (Self) -> Void) -> Self {
    //        withObservationTracking {
    //            closure(self)
    //        } onChange: {
    //            Task { @MainActor [weak self] in
    //                self?.with(closure)
    //            }
    //        }
    //
    //        return self
    //    }

    func with(_ proxy: @escaping (Self.Representable) -> Void) -> Modifier<Self> {
        Modifier(self, proxy)
    }

    func padding(_ value: CGFloat) -> Padding<Self> {
        Padding(value, { self })
    }
}

// MARK: - Layer modifiers
extension RepresentableNode {
    func backgroundColor(_ color: @autoclosure @escaping () -> CGColor) -> Modifier<Self> {
        Modifier(self) { view in
            createEffect { [weak view] in
                guard let view else { return }
                view.layer.backgroundColor = color()
            }
        }
    }

    func backgroundColor(_ color: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { view in
            createEffect { [weak view] in
                guard let view else { return }
                view.layer.backgroundColor = color().cgColor
            }
        }
    }

    func cornerRadius(_ radius: @autoclosure @escaping () -> CGFloat) -> Modifier<Self> {
        Modifier(self) { view in
            createEffect { [weak view] in
                guard let view else { return }
                view.layer.cornerRadius = radius()
            }
        }
    }

    func borderWidth(_ width: @autoclosure @escaping () -> CGFloat) -> Modifier<Self> {
        Modifier(self) { view in
            createEffect { [weak view] in
                guard let view else { return }
                view.layer.borderWidth = width()
            }
        }
    }

    func borderColor(_ color: @autoclosure @escaping () -> CGColor) -> Modifier<Self> {
        Modifier(self) { view in
            createEffect { [weak view] in
                guard let view else { return }
                view.layer.borderColor = color()
            }
        }
    }

    func borderColor(_ color: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { view in
            createEffect { [weak view] in
                guard let view else { return }
                view.layer.borderColor = color().cgColor
            }
        }
    }

    func alpha(_ value: @autoclosure @escaping () -> CGFloat) -> Modifier<Self> {
        Modifier(self) { view in
            createEffect { [weak view] in
                guard let view else { return }
                view.alpha = value()
            }
        }
    }

    func isHidden(_ hidden: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { view in
            createEffect { [weak view] in
                guard let view else { return }
                view.isHidden = hidden()
            }
        }
    }

    /// Escape hatch for custom reactive bindings on the built UIView.
    func withEffect(_ effect: @escaping (Self.Representable) -> Void) -> Modifier<Self> {
        Modifier(self) { view in
            createEffect { [weak view] in
                guard let view else { return }
                effect(view)
            }
        }
    }
}

// MARK: - UILabel modifiers
extension RepresentableNode where Representable == UILabel {
    func textColor(_ color: @autoclosure @escaping () -> UIColor) -> Modifier<Self> {
        Modifier(self) { label in
            createEffect { [weak label] in
                guard let label else { return }
                label.textColor = color()
            }
        }
    }

    func font(_ font: @autoclosure @escaping () -> UIFont) -> Modifier<Self> {
        Modifier(self) { label in
            createEffect { [weak label] in
                guard let label else { return }
                label.font = font()
            }
        }
    }

    func numberOfLines(_ lines: @autoclosure @escaping () -> Int) -> Modifier<Self> {
        Modifier(self) { label in
            createEffect { [weak label] in
                guard let label else { return }
                label.numberOfLines = lines()
            }
        }
    }
}

struct Modifier<ModifiedNode: RepresentableNode>: RepresentableNode {
    private let node: ModifiedNode
    private let modifier: (ModifiedNode.Representable) -> Void

    init(
        _ node: ModifiedNode,
        _ modifier: @escaping (ModifiedNode.Representable) -> Void
    ) {
        self.node = node
        self.modifier = modifier
    }

    func build() -> ModifiedNode.Representable {
        let view = node.build()
        modifier(view)
        return view
    }
}

struct Button: RepresentableNode {
    private let title: () -> String
    private let action: () -> Void

    init(_ title: @autoclosure @escaping () -> String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    func build() -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction { _ in action() }, for: .touchUpInside)
        createEffect { [weak button] in
            guard let button else { return }
            button.setTitle(self.title(), for: .normal)
        }
        return button
    }
}

struct Padding<NodeContent: RepresentableNode>: RepresentableNode {
    private let insets: UIEdgeInsets
    private let content: NodeContent

    init(_ padding: CGFloat, @NodeBuilder _ content: () -> NodeContent) {
        self.insets = .init(top: padding, left: padding, bottom: padding, right: padding)
        self.content = content()
    }

    init(insets: UIEdgeInsets, @NodeBuilder _ content: () -> NodeContent) {
        self.insets = insets
        self.content = content()
    }

    func build() -> UIView {
        let child = content.build()
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(child)

        NSLayoutConstraint.activate([
            child.topAnchor.constraint(equalTo: container.topAnchor, constant: insets.top),
            child.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: insets.left),
            child.trailingAnchor.constraint(
                equalTo: container.trailingAnchor, constant: -insets.right),
            child.bottomAnchor.constraint(
                equalTo: container.bottomAnchor, constant: -insets.bottom),
        ])

        return container
    }
}

struct Stack<Content: RepresentableNode>: RepresentableNode {
    private let axis: NSLayoutConstraint.Axis
    private let spacing: CGFloat
    private let alignment: UIStackView.Alignment

    private let content: Content

    init(
        _ axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0,
        alignment: UIStackView.Alignment = .fill, @NodeBuilder _ content: () -> Content
    ) {
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment

        self.content = content()
    }

    func build() -> UIStackView {
        let children = content.buildList()
        print("Children: \(children.count)")
        let stack = UIStackView(arrangedSubviews: children)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = axis
        stack.spacing = spacing
        stack.alignment = alignment
        stack.distribution = .equalSpacing

        return stack
    }
}

// MARK: - UIStackView modifiers
extension RepresentableNode where Representable == UIStackView {
    func margins(_ insets: @autoclosure @escaping () -> UIEdgeInsets) -> Modifier<Self> {
        Modifier(self) { stack in
            createEffect { [weak stack] in
                guard let stack else { return }
                stack.layoutMargins = insets()
                stack.isLayoutMarginsRelativeArrangement = true
            }
        }
    }
}

//struct Group<Content: RepresentableNode>: RepresentableNode {
//    private let content: Content
//
//    init(@NodeBuilder _ content: () -> Content) {
//        self.content = content()
//    }
//
//    func build(in context: BuildContext) -> UIView {
//        let container = Stack(.vertical, { content })
//        return container.build(in: context)
//    }
//
//    func buildList(in context: BuildContext) -> [UIView] {
//        content.buildList(in: context)
//    }
//
//    func buildViewControllerList(in context: BuildContext) -> [UIViewController] {
//        content.buildViewControllerList(in: context)
//    }
//}

#Preview {
    SwiftUI.VStack {
        SwiftUI.Text("Miau")
            .frame(height: 900)
        //            .background(.blue)

        SwiftUI.Text("Miau")
            .frame(height: 900)
        //            .background(.blue)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.red)
    .padding(20)
    .background(.green)
}
