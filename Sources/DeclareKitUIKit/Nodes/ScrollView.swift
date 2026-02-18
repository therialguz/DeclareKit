//
//  ScrollView.swift
//  DeclareKit
//
//  Created by Benjamín Guzmán López on 09-02-26.
//

import UIKit

/// A declarative wrapper around `UIScrollView`.
public struct ScrollView<Content: RepresentableNode>: RepresentableNode {
    public typealias Representable = UIScrollView
    
    private let content: () -> Content

    /// Creates a scroll view with the provided content.
    public init(@NodeBuilder _ content: @escaping () -> Content) {
        self.content = content
    }

    /// Builds a `UIScrollView` and pins the content to its layout guides.
    public func build(in context: BuildContext) {
        let scrollView = UIScrollView()
        context.insertChild(scrollView, nil)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])
        
        let scrollViewContext = BuildContext(parent: contentView)

        content().build(in: scrollViewContext)
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
    /// Sets `isPagingEnabled` on a scroll view.
    public func isPagingEnabled(_ isPagingEnabled: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.isPagingEnabled = isPagingEnabled() }
    }

    /// Sets `isScrollEnabled` on a scroll view.
    public func isScrollEnabled(_ isScrollEnabled: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.isScrollEnabled = isScrollEnabled() }
    }

    /// Sets `bounces` on a scroll view.
    public func bounces(_ bounces: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.bounces = bounces() }
    }

    /// Sets `bouncesZoom` on a scroll view.
    public func bouncesZoom(_ bouncesZoom: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.bouncesZoom = bouncesZoom() }
    }

    /// Sets `bouncesVertically` on a scroll view.
    public func bouncesVertically(_ bouncesVertically: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.bouncesVertically = bouncesVertically() }
    }

    /// Sets `bouncesHorizontally` on a scroll view.
    public func bouncesHorizontally(_ bouncesHorizontally: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.bouncesHorizontally = bouncesHorizontally() }
    }

    /// Sets `isDirectionalLockEnabled` on a scroll view.
    public func isDirectionalLockEnabled(_ isDirectionalLockEnabled: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.isDirectionalLockEnabled = isDirectionalLockEnabled() }
    }
    
    public func showsVerticalScrollIndicator(_ showsVerticalScrollIndicator: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.showsVerticalScrollIndicator = showsVerticalScrollIndicator() }
    }
    
    public func showsHorizontalScrollIndicator(_ showsHorizontalScrollIndicator: @autoclosure @escaping () -> Bool) -> Modifier<Self> {
        Modifier(self) { $0.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator() }
    }
    
    public func contentInset(_ contentInset: @autoclosure @escaping () -> UIEdgeInsets) -> Modifier<Self> {
        Modifier(self) { $0.contentInset = contentInset() }
    }
    
    public func keyboardDismissMode(_ keyboardDismissMode: @autoclosure @escaping () -> UIScrollView.KeyboardDismissMode) -> Modifier<Self> {
        Modifier(self) { $0.keyboardDismissMode = keyboardDismissMode() }
    }
    
    public func topEdgeEffect(style: @autoclosure @escaping () -> UIScrollEdgeEffect.Style) -> Modifier<Self> {
        Modifier(self) { $0.topEdgeEffect.style = style() }
    }
}
