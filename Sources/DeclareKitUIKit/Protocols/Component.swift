//
//  Component.swift
//  DeclareKit
//
//  Created by Benjamín Guzmán López on 08-02-26.
//

import UIKit

public protocol Component: RepresentableNode {
    associatedtype Body: RepresentableNode
    @NodeBuilder var body: Body { get }
}

extension Component {
    public func build() -> Body.Representable {
        body.build()
    }

    public func buildList() -> [UIView] {
        body.buildList()
    }
}
