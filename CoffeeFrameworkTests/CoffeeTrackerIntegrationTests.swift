//
//  CoffeeTrackerIntegrationTests.swift
//  Track My Coffee
//
//  Created by Jarret on 09/02/2025.
//


import Testing
import CoffeeFramework

class CoffeeTrackerIntegrationTests {

    private static let domain = String(describing: CoffeeTrackControllerTests.self)
    let defaults: UserDefaults

    init() {
        let domain = CoffeeTrackerIntegrationTests.domain

        let defaults = UserDefaults(suiteName: domain)!
        defaults.removePersistentDomain(forName: domain)
        self.defaults = defaults
    }

    deinit {
        let domain = CoffeeTrackerIntegrationTests.domain

        let defaults = UserDefaults(suiteName: domain)!
        defaults.removePersistentDomain(forName: domain)
    }


    @Test func doesInit() {
        let sut = makeSUT()
        #expect(sut != nil)
    }

    @Test func doesIncrement() {
        let sut = makeSUT()
        sut.perform(.increment)

        #expect(sut.count == 1)
    }

    @Test func doesDecrement() {
        let sut = makeSUT()
        sut.perform(.increment)
        sut.perform(.decrement)

        #expect(sut.count == 0)
    }

    @Test func doesReturnNewStateOnNextDay()  {
        let sut = makeSUT()
        sut.perform(.increment)
        sut.perform(.increment)
        let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!

        let newSUT = makeSUT(for: nextDay
        )
        #expect(newSUT.count == 0)
    }


    // MARK: Helpers

    private func makeSUT(for date: Date = Date.now) -> CoffeeTrackController {
        let store = TrackerStore(defaults: defaults, storageKey: "store-\(CoffeeTrackerIntegrationTests.domain))")
        return CoffeeTrackController(date: date, store: store)
    }
}
