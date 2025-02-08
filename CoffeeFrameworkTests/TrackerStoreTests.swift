//
//  TrackerStoreTests.swift
//  TrackerStoreTests
//
//  Created by Jarret on 08/02/2025.
//

import Testing
import Foundation

class TrackerStore {

    let store = [String: Int]()

    /// retrieves tracked number
    func retrieve(_ date: Date) -> Int? {
        return nil
    }

    func store(number: Int, for date: Date) {

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

    // MARK: Helpers

    private func makeSUT() -> TrackerStore {
        let sut = TrackerStore()
        return sut
    }
}
