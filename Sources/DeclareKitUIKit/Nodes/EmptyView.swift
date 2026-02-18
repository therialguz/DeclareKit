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
    /// Creates an empty view node.
    public init() {}

    /// Builds an empty `UIView` instance.
    public func build(in context: BuildContext) -> some UIView {
        UIView()
    }

    /// Returns no views — an empty node contributes nothing to a list.
    public func buildList(in context: BuildContext) -> [UIView] {
        []
    }
}
