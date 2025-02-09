//
//  CoffeeTrackerIntegrationTests.swift
//  Track My Coffee
//
//  Created by Jarret on 09/02/2025.
//


import Testing
import CoffeeFramework

class CoffeeTrackerIntegrationTests {

    let sut: CoffeeTrackController

    init() {
        let domain = String(describing: CoffeeTrackControllerTests.self)
        let defaults = UserDefaults(suiteName: domain)!
        defaults.removePersistentDomain(forName: domain)

        let store = TrackerStore(defaults: defaults, storageKey: "store-\(domain))")
        self.sut = CoffeeTrackController(date: Date.now, store: store)
    }

    deinit {
        let domain = String(describing: CoffeeTrackControllerTests.self)
        let defaults = UserDefaults(suiteName: domain)!
        defaults.removePersistentDomain(forName: domain)
    }


    @Test func doesInit() {

        #expect(sut != nil)
    }
}
