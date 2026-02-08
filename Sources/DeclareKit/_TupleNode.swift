//
//  _TupleNode.swift
//  GHFollowers
//
//  Created by Benjamín Guzmán López on 06-02-26.
//

import UIKit

struct _TupleNode<each Child: RepresentableNode>: RepresentableNode {
    public let children: (repeat each Child)

    init(_ value: repeat each Child) {
        self.children = (repeat each value)
    }

    func build(in context: BuildContext) -> some UIView {
        // if someone asks for a single view, wrap
        let container = UIView()
        for child in buildList(in: context) { container.addSubview(child) }
        return container
    }

    func buildList(in context: BuildContext) -> [UIView] {
        var views: [UIView] = []

        for child in repeat each children {
            views.append(contentsOf: child.buildList(in: context))
        }

        return views
    }

    //    public static func _render<Renderer: HTMLRenderer>(_ content: _TupleComponent<repeat each Child>, into renderer: inout Renderer) async throws {
    //        func render<Element: Component>(_ element: Element, into renderer: inout Renderer) async throws {
    //            try await Element._render(element, into: &renderer)
    //        }
    //
    //        repeat try await render(each content.children, into: &renderer)
    //    }
}
