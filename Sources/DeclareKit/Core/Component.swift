//
//  Component.swift
//  DeclareKit
//
//  Created by Benjamín Guzmán López on 08-02-26.
//

import UIKit

protocol Component: RepresentableNode {
    associatedtype Body: RepresentableNode
    @NodeBuilder var body: Body { get }
}

extension Component {
    func build() -> Body.Representable {
        body.build()
    }

    func buildList() -> [UIView] {
        body.buildList()
    }
}
