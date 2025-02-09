//
//  CoffeeTrackControllerTests.swift
//  Track My Coffee
//
//  Created by Jarret on 09/02/2025.
//


import Testing
import CoffeeFramework

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

    @Test func doesNotDecrementOnZero() async throws {
        let sut = makeSUT()
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
