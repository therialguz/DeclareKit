/// A result builder for composing RepresentableController hierarchies.
///
/// This builder mirrors @NodeBuilder but works with view controllers instead of views.
/// It supports conditional logic, optional controllers, and multiple controllers.
@resultBuilder
@MainActor
public struct ControllerBuilder {
    /// Builds an empty controller when the builder block is empty.
    public static func buildBlock() -> EmptyController {
        EmptyController()
    }

    /// Builds a single controller.
    public static func buildBlock<C: RepresentableController>(_ controller: C) -> C {
        controller
    }

    /// Builds multiple controllers using parameter packs.
    public static func buildBlock<each C: RepresentableController>(
        _ content: repeat each C
    ) -> _TupleController<repeat each C> {
        _TupleController(repeat each content)
    }

    /// Allows any RepresentableController to be used in the builder.
    public static func buildExpression<C: RepresentableController>(_ controller: C) -> C {
        controller
    }
}
