//
//  Signal.swift
//  DeclareKit
//
//  Created by Benjamín Guzmán López on 07-02-26.
//

import Observation

@Observable
final class SignalStorage<T> {
    var value: T

    init(value: T) {
        self.value = value
    }
}

@propertyWrapper
struct Signal<T> {
    private let storage: SignalStorage<T>

    var wrappedValue: T {
        get { storage.value }
        nonmutating set { storage.value = newValue }
    }

    /// Exposes the same signal instance, not a copied value.
    var projectedValue: Binding<T> { Binding(get: { wrappedValue }, set: { wrappedValue = $0 }) }

    /// Creates a new root signal.
    init(wrappedValue: T) {
        self.storage = SignalStorage(value: wrappedValue)
    }
}

