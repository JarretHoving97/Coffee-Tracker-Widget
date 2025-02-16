//
//  CoffeeTrackerViewModelTests.swift
//  Track My Coffee
//
//  Created by Jarret on 09/02/2025.
//

import Testing
import CoffeeFramework

struct CoffeeTrackerViewModelTest {

    let sut = CoffeeTrackerViewModel(
        controller: CoffeeTrackController(
            date: Date.now,
            store: TrackerStoreMock()
        )
    )

    @Test func doesIncrement() {
        #expect(sut.coffeeCount == 0)
        sut.increment()
        #expect(sut.coffeeCount == 1)
    }

    @Test func doesDecrement() {
        sut.increment()
        #expect(sut.coffeeCount == 1)
        sut.decrement()
        #expect(sut.coffeeCount == 0)
    }
}
