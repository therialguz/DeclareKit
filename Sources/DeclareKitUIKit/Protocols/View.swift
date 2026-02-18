//
//  View.swift
//  DeclareKit
//
//  Created by Benjamín Guzmán López on 08-02-26.
//

import UIKit

public protocol View: RepresentableNode {
    /// The rendered node content for this component.
    associatedtype Body: RepresentableNode

    /// The declarative content of this component.
    @NodeBuilder var body: Body { get }
}

extension View {
    /// Builds this component by building its `body`.
    public func build(in context: BuildContext) {
        body.build(in: context)
    }
}
