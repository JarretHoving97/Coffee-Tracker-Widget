//
//  TrackerStore.swift
//  Track My Coffee
//
//  Created by Jarret on 09/02/2025.
//

import Foundation

public class TrackerStore {

    private let defaults: UserDefaults
    private let storageKey: String

    public init(defaults: UserDefaults, storageKey: String) {
        self.defaults = defaults
        self.storageKey = storageKey
    }

    public func retrieve(_ date: Date) -> Int? {
        let dictionary = defaults.dictionary(forKey: storageKey) as? [String: Int]
        return dictionary?[formatDate(date)]
    }

    public func store(number: Int, for date: Date) {
        var dictionary = defaults.dictionary(forKey: storageKey) as? [String: Int] ?? [:]
        dictionary[formatDate(date)] = number
        defaults.setValue(dictionary, forKey: storageKey)
    }

    // Function to format a Date to a string (e.g., "2025-02-08")
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
