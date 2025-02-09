//
//  TrackerStoreTests.swift
//  TrackerStoreTests
//
//  Created by Jarret on 08/02/2025.
//

import Testing
import Foundation
import CoffeeFramework

@Suite(.serialized)
class CoffeeFrameworkTests{

    private static let domain = String(describing: CoffeeFrameworkTests.self)

    private let sut: TrackerStore

    init() {
        let defaults = UserDefaults(suiteName: CoffeeFrameworkTests.domain)!
        defaults.removePersistentDomain(forName: CoffeeFrameworkTests.domain)
        sut = TrackerStore(defaults: defaults, storageKey: "test_coffee_tracker")
    }

    deinit {
        let defaults = UserDefaults(suiteName: CoffeeFrameworkTests.domain)!
        defaults.removePersistentDomain(forName: CoffeeFrameworkTests.domain)
    }

    @Test func doesInit() {
        let sut = sut
        #expect(sut != nil)
    }

    @Test func doesReturnZeroWehaveNotTrackedForDate() {
        let sut = sut
        #expect(sut.retrieve(Date()) == nil)
    }

    @Test func doesNotReturnZeroWhenWeHaveTrackedForDate() {
        let sut = sut
        sut.store(number: 1, for: Date())
        #expect(sut.retrieve(Date()) != nil)
    }

    @Test func doesReturnDifferentNumberForDifferentDate() {
        let sut = sut
        sut.store(number: 1, for: Date())
        let differentDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        #expect(sut.retrieve(differentDate) == nil)
    }

    @Test func doesSaveDataInLocalStorage() async throws {
        let sut1 = sut
        let date = Date()
        sut1.store(number: 1, for: date)

        let sut2 = sut

        #expect(sut1.retrieve(date) == sut2.retrieve(date))
    }

    @Test func doesReturnNewStateOnNextDay() async throws {
        let sut = sut
        let date = Date()
        sut.store(number: 1, for: date)
        
        let differentDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!

        #expect(sut.retrieve(date) != sut.retrieve(differentDate))
        #expect(sut.retrieve(differentDate) == nil)
    }
}
