//
//  ScrollView.swift
//  DeclareKit
//
//  Created by Benjamín Guzmán López on 09-02-26.
//

import UIKit

public struct ScrollView<Content: RepresentableNode>: RepresentableNode {
    private let content: () -> Content

    public init(@NodeBuilder _ content: @escaping () -> Content) {
        self.content = content
    }

    public func build() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        let contentView = content().build()
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])

        return scrollView
    }
}

#Preview {
    NavigationController {
        ViewController {
            ScrollView {
                Stack(.vertical, spacing: 200) {
                    Label("Hello World! This is really big!!!")
                        .backgroundColor(.green)

                    Label("Hello World! This is really big!!!")
                        .backgroundColor(.green)

                    Label("Hello World! This is really big!!!")
                        .backgroundColor(.green)

                    Label("Hello World! This is really big!!!")
                        .backgroundColor(.green)

                    Label("Hello World! This is really big!!!")
                        .backgroundColor(.green)

                    Label("Hello World! This is really big!!!")
                        .backgroundColor(.green)

                    Label("Hello World! This is really big!!!")
                        .backgroundColor(.green)
                }
                .backgroundColor(.blue)
            }
            .backgroundColor(.red)
        }
        .title("Hello ScrollView!")
        .navigationItem(largeTitleDisplayMode: .always)
        .navigationItem(largeTitle: "Large Title")
    }
    .navigationItem(largeTitleDisplayMode: .always)
    .navigationItem(largeTitle: "Large Title")
    .navigationBar(prefersLargeTitles: true)
    .buildController()
}

extension RepresentableNode where Representable == UIScrollView {
    public func isPagingEnabled(_ isPagingEnabled: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.isPagingEnabled = isPagingEnabled() }
    }

    public func isScrollEnabled(_ isScrollEnabled: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.isScrollEnabled = isScrollEnabled() }
    }

    public func bounces(_ bounces: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.bounces = bounces() }
    }

    public func bouncesZoom(_ bouncesZoom: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.bouncesZoom = bouncesZoom() }
    }

    public func bouncesVertically(_ bouncesVertically: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.bouncesVertically = bouncesVertically() }
    }

    public func bouncesHorizontally(_ bouncesHorizontally: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.bouncesHorizontally = bouncesHorizontally() }
    }

    public func isDirectionalLockEnabled(_ isDirectionalLockEnabled: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.isDirectionalLockEnabled = isDirectionalLockEnabled() }
    }
}
