//
//  Binding.swift
//  DeclareKit
//
//  Created by Codex on 08-02-26.
//

@propertyWrapper
public struct Binding<T> {
    private let getter: () -> T
    private let setter: (T) -> Void

    public var wrappedValue: T {
        get { getter() }
        nonmutating set { setter(newValue) }
    }

    public var projectedValue: () -> T {
        getter
    }

    public init(get: @escaping () -> T, set: @escaping (T) -> Void) {
        getter = get
        setter = set
    }

    public init(projectedValue: Binding<T>) {
        getter = projectedValue.getter
        setter = projectedValue.setter
    }
}
