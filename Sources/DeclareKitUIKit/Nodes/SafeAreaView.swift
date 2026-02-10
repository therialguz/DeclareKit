//
//  SafeAreaView.swift
//  DeclareKit
//
//  Created by Benjamín Guzmán López on 09-02-26.
//

import UIKit

public struct SafeAreaView<T: RepresentableNode>: RepresentableNode {
    private let content: () -> T

    public init(@NodeBuilder _ content: @escaping () -> T) {
        self.content = content
    }

    public func build() -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        let views = content().buildList()
        for view in views {
            container.addSubview(view)

            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor),
                view.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor),
            ])
        }

        return container
    }
}
