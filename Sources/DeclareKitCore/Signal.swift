//
//  Signal.swift
//  DeclareKit
//
//  Created by Benjamín Guzmán López on 07-02-26.
//

import Observation

@Observable
public final class SignalStorage<T> {
    public var value: T

    public init(value: T) {
        self.value = value
    }
}

@propertyWrapper
public struct Signal<T> {
    private let storage: SignalStorage<T>

    public var wrappedValue: T {
        get { storage.value }
        nonmutating set { storage.value = newValue }
    }

    /// Exposes the same signal instance, not a copied value.
    public var projectedValue: Binding<T> { Binding(get: { wrappedValue }, set: { wrappedValue = $0 }) }

    /// Creates a new root signal.
    public init(wrappedValue: T) {
        self.storage = SignalStorage(value: wrappedValue)
    }
}
