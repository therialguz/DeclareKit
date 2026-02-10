//
//  Component.swift
//  DeclareKit
//
//  Created by Benjamín Guzmán López on 08-02-26.
//

import UIKit

/// A reusable declarative view component.
///
/// Conforming types describe their content in `body` and automatically
/// forward rendering through the underlying `RepresentableNode`.
public protocol Component: RepresentableNode {
    /// The rendered node content for this component.
    associatedtype Body: RepresentableNode

    /// The declarative content of this component.
    @NodeBuilder var body: Body { get }
}

extension Component {
    /// Builds this component by building its `body`.
    public func build() -> Body.Representable {
        body.build()
    }

    /// Builds this component as a flattened list of views.
    public func buildList() -> [UIView] {
        body.buildList()
    }
}
