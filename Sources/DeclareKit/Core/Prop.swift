//
//  Prop.swift
//  DeclareKit
//
//  Created by Codex on 08-02-26.
//

@propertyWrapper
struct Prop<T> {
    private let getter: () -> T

    var wrappedValue: T {
        getter()
    }

    var projectedValue: () -> T {
        getter
    }

    init(wrappedValue: @autoclosure @escaping () -> T) {
        self.getter = wrappedValue
    }

    init(_ getter: @escaping () -> T) {
        self.getter = getter
    }
}
