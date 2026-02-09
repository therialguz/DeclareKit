//
//  Binding.swift
//  DeclareKit
//
//  Created by Codex on 08-02-26.
//

@propertyWrapper
struct Binding<T> {
    private let getter: () -> T
    private let setter: (T) -> Void

    var wrappedValue: T {
        get { getter() }
        nonmutating set { setter(newValue) }
    }

    var projectedValue: () -> T {
        getter
    }

    init(get: @escaping () -> T, set: @escaping (T) -> Void) {
        getter = get
        setter = set
    }
    
    init(projectedValue: Binding<T>) {
        getter = projectedValue.getter
        setter = projectedValue.setter
    }
}
