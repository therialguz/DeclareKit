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

extension NodeBuilder {
    /// Produces an optional component for conditional statements in multi-statement
    /// closures that's only visible when the condition evaluates to true.
    public static func buildIf<Content>(_ content: Content?) -> Content? where Content : RepresentableNode {
        content
    }

    /// Produces content for a conditional statement in a multi-statement closure
    /// when the condition is true.
    public static func buildEither<TrueContent, FalseContent>(first: TrueContent) -> _ConditionalNode<TrueContent, FalseContent> where TrueContent : RepresentableNode, FalseContent : RepresentableNode {
        _ConditionalNode(storage: .trueContent(first))
    }

    /// Produces content for a conditional statement in a multi-statement closure
    /// when the condition is false.
    public static func buildEither<TrueContent, FalseContent>(second: FalseContent) -> _ConditionalNode<TrueContent, FalseContent> where TrueContent : RepresentableNode, FalseContent : RepresentableNode {
        _ConditionalNode(storage: .falseContent(second))
    }
}
