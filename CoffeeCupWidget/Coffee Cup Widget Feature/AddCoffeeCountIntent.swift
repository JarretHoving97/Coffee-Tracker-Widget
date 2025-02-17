//
//  AddCoffeeCountIntent.swift
//  Track My Coffee
//
//  Created by Jarret on 09/02/2025.
//

import SwiftUI
import AppIntents
@preconcurrency import CoffeeFramework

public struct AddCoffeeIntent: AppIntent {

    public static var title: LocalizedStringResource = "Add Coffee"

    private let controller = CoffeeTrackController(date: .now, store: TrackerStores.coffeeTracker)

    public init() {}
    
    public func perform() async throws -> some IntentResult {
        controller.perform(.increment)
        return .result()
    }
}

public struct DecrementCoffeeIntent: AppIntent {

    public static var title: LocalizedStringResource = "decrement Coffee"

    private let controller = CoffeeTrackController(date: .now, store: TrackerStores.coffeeTracker)

    public init() {}

    public func perform() async throws -> some IntentResult {
        controller.perform(.decrement)
        return .result()
    }
}
