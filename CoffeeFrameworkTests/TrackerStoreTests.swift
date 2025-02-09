//
//  TrackerStoreTests.swift
//  TrackerStoreTests
//
//  Created by Jarret on 08/02/2025.
//

import Testing
import Foundation

class TrackerStore {

    private let defaults: UserDefaults
    private let storageKey = "trackedCoffeNumbers"

    init(defaults: UserDefaults) {
        self.defaults = defaults
    }

    func retrieve(_ date: Date) -> Int? {
        let dictionary = defaults.dictionary(forKey: storageKey) as? [String: Int]
        return dictionary?[formatDate(date)]
    }

    func store(number: Int, for date: Date) {
        var dictionary = defaults.dictionary(forKey: storageKey) as? [String: Int] ?? [:]
        dictionary[formatDate(date)] = number
        defaults.setValue(dictionary, forKey: storageKey)
    }

    // Function to format a Date to a string (e.g., "2025-02-08")
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

struct CoffeeFrameworkTests {

    @Test func doesInit() {
        let sut = makeSUT()
        #expect(sut != nil)
    }

    @Test func doesReturnZeroWehaveNotTrackedForDate() {
        let sut = makeSUT()
        #expect(sut.retrieve(Date()) == nil)
    }

    @Test func doesNotReturnZeroWhenWeHaveTrackedForDate() {
        let sut = makeSUT()
        sut.store(number: 1, for: Date())
        #expect(sut.retrieve(Date()) != nil)
    }

    @Test func doesReturnDifferentNumberForDifferentDate() {
        let sut = makeSUT()
        sut.store(number: 1, for: Date())
        let differentDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        #expect(sut.retrieve(differentDate) == nil)
    }


    @Test func doesSaveDataInLocalStorage() async throws {
        let sut1 = makeSUT()
        let date = Date()
        sut1.store(number: 1, for: date)

        let sut2 = makeSUT()

        #expect(sut1.retrieve(date) == sut2.retrieve(date))
    }

    @Test func doesReturnNewStateOnNextDay() async throws {
        let sut = makeSUT()
        let date = Date()
        sut.store(number: 1, for: date)
        
        let differentDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!

        #expect(sut.retrieve(date) != sut.retrieve(differentDate))
        #expect(sut.retrieve(differentDate) == nil)
    }


    // MARK: Helpers

    private func makeSUT() -> TrackerStore {
        let sut = TrackerStore(defaults: UserDefaults(suiteName: "/dev/null")!)
        return sut
    }
}
