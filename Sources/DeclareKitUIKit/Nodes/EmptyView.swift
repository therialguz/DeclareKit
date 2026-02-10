//
//  EmptyView.swift
//  GHFollowers
//
//  Created by Benjamín Guzmán López on 06-02-26.
//

import UIKit

public struct EmptyView: RepresentableNode {
    public init() {}

    public func build() -> some UIView {
        UIView()
    }
}
