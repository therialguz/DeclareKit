//
//  _ConditionalNode.swift
//  GHFollowers
//
//  Created by Benjamín Guzmán López on 06-02-26.
//

import UIKit

struct _ConditionalNode<TrueContent: RepresentableNode, FalseContent: RepresentableNode>:
    RepresentableNode
{
    enum Storage {
        case trueContent(TrueContent)
        case falseContent(FalseContent)
    }

    let storage: Storage

    func build(in context: BuildContext) -> UIView {
        switch storage {
        case .trueContent(let trueContent):
            trueContent.build(in: context)
        case .falseContent(let falseContent):
            falseContent.build(in: context)
        }
    }
}
