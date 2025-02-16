//
//  CoffeeTrackerController.swift
//  Track My Coffee
//
//  Created by Jarret on 09/02/2025.
//


public class CoffeeTrackController {

    public enum Action {
        case increment
        case decrement
    }

    private let store: TrackerStoreProtocol
    private let date: Date

    public var count: Int {
        return max(store.retrieve(date) ?? 0, 0)
    }

    public init(date: Date, store: TrackerStoreProtocol) {
        self.store = store
        self.date = date
    }

    public func perform(_ action: Action) {
        switch action {
        case .increment:
            store.store(number: count + 1, for: date)
        case .decrement:
            store.store(number: count - 1, for: date)
        }
    }
}
