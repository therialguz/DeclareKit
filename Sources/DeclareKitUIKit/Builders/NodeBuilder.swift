//
//  NodeBuilder.swift
//  GHFollowers
//
//  Created by Benjamín Guzmán López on 06-02-26.
//

@resultBuilder
@MainActor
public enum NodeBuilder {
    /// Builds an expression within the builder.
    public static func buildExpression<Content>(_ content: Content) -> Content where Content : RepresentableNode {
        content
    }

    /// Builds an empty component from a block containing no statements.
    public static func buildBlock() -> EmptyView {
        EmptyView()
    }

    /// Passes a single component written as a child component through unmodified.
    ///
    /// An example of a single view written as a child view is
    /// `{ p("Hello") }`.
    public static func buildBlock<Content>(_ content: Content) -> Content where Content : RepresentableNode {
        content
    }

    public static func buildBlock<each Content>(_ content: repeat each Content) -> _TupleNode<repeat each Content> where repeat each Content : RepresentableNode {
        _TupleNode(repeat each content)
    }
}
