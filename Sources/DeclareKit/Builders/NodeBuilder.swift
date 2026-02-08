//
//  NodeBuilder.swift
//  GHFollowers
//
//  Created by Benjamín Guzmán López on 06-02-26.
//

@resultBuilder
@MainActor
enum NodeBuilder {
    /// Builds an expression within the builder.
    static func buildExpression<Content>(_ content: Content) -> Content where Content : RepresentableNode {
        content
    }

    /// Builds an empty component from a block containing no statements.
    static func buildBlock() -> EmptyView {
        EmptyView()
    }

    /// Passes a single component written as a child component through unmodified.
    ///
    /// An example of a single view written as a child view is
    /// `{ p("Hello") }`.
    static func buildBlock<Content>(_ content: Content) -> Content where Content : RepresentableNode {
        content
    }

    static func buildBlock<each Content>(_ content: repeat each Content) -> _TupleNode<repeat each Content> where repeat each Content : RepresentableNode {
        _TupleNode(repeat each content)
    }
}

extension NodeBuilder {
    /// Produces an optional component for conditional statements in multi-statement
    /// closures that's only visible when the condition evaluates to true.
    static func buildIf<Content>(_ content: Content?) -> Content? where Content : RepresentableNode {
        content
    }

    /// Produces content for a conditional statement in a multi-statement closure
    /// when the condition is true.
    static func buildEither<TrueContent, FalseContent>(first: TrueContent) -> _ConditionalNode<TrueContent, FalseContent> where TrueContent : RepresentableNode, FalseContent : RepresentableNode {
        _ConditionalNode(storage: .trueContent(first))
    }

    /// Produces content for a conditional statement in a multi-statement closure
    /// when the condition is false.
    static func buildEither<TrueContent, FalseContent>(second: FalseContent) -> _ConditionalNode<TrueContent, FalseContent> where TrueContent : RepresentableNode, FalseContent : RepresentableNode {
        _ConditionalNode(storage: .falseContent(second))
    }
}
