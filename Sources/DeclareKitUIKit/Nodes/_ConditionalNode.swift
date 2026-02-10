//
//  _ConditionalNode.swift
//  GHFollowers
//
//  Created by Benjamín Guzmán López on 06-02-26.
//

import UIKit

public struct _ConditionalNode<TrueContent: RepresentableNode, FalseContent: RepresentableNode>:
    RepresentableNode
{
    public enum Storage {
        case trueContent(TrueContent)
        case falseContent(FalseContent)
    }

    public let storage: Storage

    public init(storage: Storage) {
        self.storage = storage
    }

    public func build() -> UIView {
        switch storage {
        case .trueContent(let trueContent):
            trueContent.build()
        case .falseContent(let falseContent):
            falseContent.build()
        }
    }
}
