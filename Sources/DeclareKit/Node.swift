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

    func build(in context: BuildContext) -> Representable

    func buildList(in context: BuildContext) -> [UIView]
}

extension RepresentableNode {
    func buildList(in context: BuildContext) -> [UIView] {
        [build(in: context)]
    }
}

//extension RepresentableNode {
//    func preview() -> HostViewController<Self> {
//        HostViewController(host: self)
//    }
//}

struct Text: RepresentableNode {
    private let text: String

    init(_ text: String) {
        self.text = text
    }

    func build(in context: BuildContext) -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = text
        return view
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

    func with(_ proxy: @escaping (Self.Representable, BuildContext) -> Void) -> Modifier<Self> {
        Modifier(self, proxy)
    }

    func padding(_ value: CGFloat) -> Padding<Self> {
        Padding(value, { self })
    }
}

// MARK: - Layer modifiers
extension RepresentableNode {
    func backgroundColor(_ color: CGColor) -> some RepresentableNode {
        Modifier(self, { view, _ in view.layer.backgroundColor = color })
    }

    func backgroundColor(_ color: UIColor) -> some RepresentableNode {
        backgroundColor(color.cgColor)
    }

    func cornerRadius(_ radius: CGFloat) -> some RepresentableNode {
        Modifier(self, { view, _ in view.layer.cornerRadius = radius })
    }

    func borderWidth(_ width: CGFloat) -> some RepresentableNode {
        Modifier(self, { view, _ in view.layer.borderWidth = width })
    }

    func borderColor(_ color: CGColor) -> some RepresentableNode {
        Modifier(self, { view, _ in view.layer.borderColor = color })
    }

    func borderColor(_ color: UIColor) -> some RepresentableNode {
        borderColor(color.cgColor)
    }
}

// MARK: - UILabel modifiers
extension RepresentableNode where Representable == UILabel {
    func textColor(_ color: UIColor) -> Modifier<Self> {
        Modifier(self, { view, _ in view.textColor = color })
    }

    func font(_ font: UIFont) -> Modifier<Self> {
        Modifier(self, { view, _ in view.font = font })
    }

    func numberOfLines(_ numberOfLinesz: Int) -> Modifier<Self> {
        Modifier(self, { view, _ in view.numberOfLines = numberOfLinesz })
    }
}

struct Modifier<ModifiedNode: RepresentableNode>: RepresentableNode {
    private let node: ModifiedNode
    private let modifier: (ModifiedNode.Representable, BuildContext) -> Void

    init(
        _ node: ModifiedNode,
        _ modifier: @escaping (ModifiedNode.Representable, BuildContext) -> Void
    ) {
        self.node = node
        self.modifier = modifier
    }

    func build(in context: BuildContext) -> ModifiedNode.Representable {
        let view = node.build(in: context)
        modifier(view, context)
        return view
    }
}

struct Button: RepresentableNode {
    private let title: String
    private let action: Action

    init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = Action(action: action)
    }

    func build(in context: BuildContext) -> UIView {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitle("CHUTa!!", for: .focused)
        button.addTarget(button, action: #selector(action.action), for: .touchUpInside)
        return button
    }

    final class Action: NSObject {

        private let _action: () -> Void

        init(action: @escaping () -> Void) {
            _action = action
            super.init()
        }

        @objc func action() {
            _action()
        }
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

    func build(in context: BuildContext) -> UIView {
        let child = content.build(in: context)
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

    func build(in context: BuildContext) -> UIStackView {
        let children = content.buildList(in: context)
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

// MARK: - UILabel modifiers
extension RepresentableNode where Representable == UIStackView {
    func margins(_ insets: UIEdgeInsets) -> Modifier<Self> {
        Modifier(
            self,
            { view, _ in
                view.layoutMargins = insets
                view.isLayoutMarginsRelativeArrangement = true
            })
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
