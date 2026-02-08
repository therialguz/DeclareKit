//
//  BuildContext.swift
//  DeclareKit
//
//  Created by Benjamín Guzmán López on 07-02-26.
//

import UIKit

@MainActor
final class BuildContext {
    let parentViewController: UIViewController

    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
    }

    convenience init() {
        self.init(parentViewController: UIViewController())
    }

    func embed(childViewController child: UIViewController) -> UIView {
        parentViewController.addChild(child)
        let childView = child.view!
        childView.translatesAutoresizingMaskIntoConstraints = false
        child.didMove(toParent: parentViewController)
        return childView
    }
}
