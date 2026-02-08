//
//  EmptyView.swift
//  GHFollowers
//
//  Created by Benjamín Guzmán López on 06-02-26.
//

import UIKit

struct EmptyView: RepresentableNode {
    func build(in context: BuildContext) -> some UIView {
        UIView()
    }
}
