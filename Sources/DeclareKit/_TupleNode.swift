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

    func build() -> some UIView {
        // if someone asks for a single view, wrap
        let container = UIView()
        for child in buildList() { container.addSubview(child) }
        return container
    }

    func buildList() -> [UIView] {
        var views: [UIView] = []

        for child in repeat each children {
            views.append(contentsOf: child.buildList())
        }

        return views
    }
}
