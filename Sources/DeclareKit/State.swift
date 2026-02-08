//
//  State.swift
//  DeclareKit
//
//  Created by Benjamín Guzmán López on 07-02-26.
//

import Observation

@Observable
class Storage<T> {
    var value: T

    init(value: T) {
        self.value = value
    }
}

@propertyWrapper
struct State<T> {
    private let storage: Storage<T>

    var wrappedValue: T {
        get { storage.value }
        nonmutating set { storage.value = newValue }
    }

    init(wrappedValue: T) {
        self.storage = Storage(value: wrappedValue)
    }
}
