/// A result builder for composing RepresentableController hierarchies.
///
/// This builder mirrors @NodeBuilder but works with view controllers instead of views.
/// It supports conditional logic, optional controllers, and multiple controllers.
@resultBuilder
@MainActor
struct ControllerBuilder {
    /// Builds an empty controller when the builder block is empty.
    static func buildBlock() -> EmptyController {
        EmptyController()
    }

    /// Builds a single controller.
    static func buildBlock<C: RepresentableController>(_ controller: C) -> C {
        controller
    }

    /// Builds a tuple of two controllers.
    static func buildBlock<C0: RepresentableController, C1: RepresentableController>(
        _ c0: C0, _ c1: C1
    ) -> _TupleController<(C0, C1)> {
        _TupleController((c0, c1))
    }

    /// Builds a tuple of three controllers.
    static func buildBlock<
        C0: RepresentableController, C1: RepresentableController, C2: RepresentableController
    >(
        _ c0: C0, _ c1: C1, _ c2: C2
    ) -> _TupleController<(C0, C1, C2)> {
        _TupleController((c0, c1, c2))
    }

    /// Builds a tuple of four controllers.
    static func buildBlock<
        C0: RepresentableController, C1: RepresentableController, C2: RepresentableController,
        C3: RepresentableController
    >(
        _ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3
    ) -> _TupleController<(C0, C1, C2, C3)> {
        _TupleController((c0, c1, c2, c3))
    }

    /// Builds a tuple of five controllers.
    static func buildBlock<
        C0: RepresentableController, C1: RepresentableController, C2: RepresentableController,
        C3: RepresentableController, C4: RepresentableController
    >(
        _ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4
    ) -> _TupleController<(C0, C1, C2, C3, C4)> {
        _TupleController((c0, c1, c2, c3, c4))
    }

    /// Builds a tuple of six controllers.
    static func buildBlock<
        C0: RepresentableController, C1: RepresentableController, C2: RepresentableController,
        C3: RepresentableController, C4: RepresentableController, C5: RepresentableController
    >(
        _ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5
    ) -> _TupleController<(C0, C1, C2, C3, C4, C5)> {
        _TupleController((c0, c1, c2, c3, c4, c5))
    }

    /// Builds a tuple of seven controllers.
    static func buildBlock<
        C0: RepresentableController, C1: RepresentableController, C2: RepresentableController,
        C3: RepresentableController, C4: RepresentableController, C5: RepresentableController,
        C6: RepresentableController
    >(
        _ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6
    ) -> _TupleController<(C0, C1, C2, C3, C4, C5, C6)> {
        _TupleController((c0, c1, c2, c3, c4, c5, c6))
    }

    /// Builds a tuple of eight controllers.
    static func buildBlock<
        C0: RepresentableController, C1: RepresentableController, C2: RepresentableController,
        C3: RepresentableController, C4: RepresentableController, C5: RepresentableController,
        C6: RepresentableController, C7: RepresentableController
    >(
        _ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7
    ) -> _TupleController<(C0, C1, C2, C3, C4, C5, C6, C7)> {
        _TupleController((c0, c1, c2, c3, c4, c5, c6, c7))
    }

    /// Builds a tuple of nine controllers.
    static func buildBlock<
        C0: RepresentableController, C1: RepresentableController, C2: RepresentableController,
        C3: RepresentableController, C4: RepresentableController, C5: RepresentableController,
        C6: RepresentableController, C7: RepresentableController, C8: RepresentableController
    >(
        _ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8
    ) -> _TupleController<(C0, C1, C2, C3, C4, C5, C6, C7, C8)> {
        _TupleController((c0, c1, c2, c3, c4, c5, c6, c7, c8))
    }

    /// Builds a tuple of ten controllers.
    static func buildBlock<
        C0: RepresentableController, C1: RepresentableController, C2: RepresentableController,
        C3: RepresentableController, C4: RepresentableController, C5: RepresentableController,
        C6: RepresentableController, C7: RepresentableController, C8: RepresentableController,
        C9: RepresentableController
    >(
        _ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8,
        _ c9: C9
    ) -> _TupleController<(C0, C1, C2, C3, C4, C5, C6, C7, C8, C9)> {
        _TupleController((c0, c1, c2, c3, c4, c5, c6, c7, c8, c9))
    }

    /// Supports `if` statements without `else`.
    static func buildOptional<C: RepresentableController>(_ controller: C?) -> C? {
        controller
    }

    /// Supports `if-else` statements - first branch.
    static func buildEither<
        TrueController: RepresentableController, FalseController: RepresentableController
    >(
        first controller: TrueController
    ) -> _ConditionalController<TrueController, FalseController> {
        .first(controller)
    }

    /// Supports `if-else` statements - second branch.
    static func buildEither<
        TrueController: RepresentableController, FalseController: RepresentableController
    >(
        second controller: FalseController
    ) -> _ConditionalController<TrueController, FalseController> {
        .second(controller)
    }

    /// Allows any RepresentableController to be used in the builder.
    static func buildExpression<C: RepresentableController>(_ controller: C) -> C {
        controller
    }
}
