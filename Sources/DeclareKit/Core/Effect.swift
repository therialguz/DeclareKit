//
//  Effect.swift
//  DeclareKit
//
//  Created by Claude on 08-02-26.
//

import Observation

/// Core reactive primitive — analogous to SolidJS `createEffect`.
///
/// Runs `body` immediately, tracks `@Observable` property accesses via
/// `withObservationTracking`. When any tracked property changes, re-runs
/// `body` on the next MainActor tick. Naturally dies when body accesses
/// no observables (e.g., a weak view reference became nil).
@MainActor
func createEffect(_ body: @escaping @MainActor () -> Void) {
    withObservationTracking {
        body()
    } onChange: {
        Task { @MainActor in
            createEffect(body)
        }
    }
}
