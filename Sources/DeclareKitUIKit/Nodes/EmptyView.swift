//
//  EmptyView.swift
//  GHFollowers
//
//  Created by Benjamín Guzmán López on 06-02-26.
//

import UIKit

/// A node that renders no visual content.
///
/// Useful as a placeholder in builders where a `RepresentableNode` is required.
public struct EmptyView: RepresentableNode {
    public typealias Representable = UIView
    
    /// Creates an empty view node.
    public init() {}

    /// Builds an empty `UIView` instance.
    public func build(in context: BuildContext) {
        context.insertChild(UIView(), nil)
    }
}
