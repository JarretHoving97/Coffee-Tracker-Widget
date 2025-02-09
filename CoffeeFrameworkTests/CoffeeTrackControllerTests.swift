//
//  CoffeeTrackControllerTests.swift
//  Track My Coffee
//
//  Created by Jarret on 09/02/2025.
//


import Testing
import CoffeeFramework

class CoffeeTrackController {

    enum Action {
        case increment
        case decrement
    }

    private let store: TrackerStoreProtocol
    private let date: Date

    var count: Int {
        return store.retrieve(date) ?? 0
    }

    init(date: Date, store: TrackerStoreProtocol) {
        self.store = store
        self.date = date
    }

    func perform(_ action: Action) {
        switch action {
        case .increment:
            store.store(number: count + 1, for: date)
        case .decrement:
            store.store(number: count - 1, for: date)
        }
    }
}

struct CoffeeTrackControllerTests {

    @Test func doesInit() async throws {
        let sut = makeSUT()
        #expect(sut != nil)
    }

    @Test func doesIncrementCoffeeCount() async throws {
        let sut = makeSUT()
        sut.perform(.increment)

        #expect(sut.count == 1)
    }

    @Test func doesDecrementCoffeeCount() async throws {
        let sut = makeSUT()
        sut.perform(.increment)
        sut.perform(.decrement)

        #expect(sut.count == 0)
    }

    // MARK: Helpers

    private func makeSUT() -> CoffeeTrackController {
        let mock = TrackerStoreMock()
        let sut = CoffeeTrackController(date: Date.now, store: mock)

        return sut
    }
}


class TrackerStoreMock: TrackerStoreProtocol {
    var values: [Date: Int] = [:]
    
    func store(number: Int, for date: Date) {
        values[date] = number
    }
    
    func retrieve(_ date: Date) -> Int? {
        return values[date]
    }
}
