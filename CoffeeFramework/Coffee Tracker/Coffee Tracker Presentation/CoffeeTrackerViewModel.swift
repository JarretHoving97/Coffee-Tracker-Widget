//
//  CoffeeTrackerViewModel.swift
//  Track My Coffee
//
//  Created by Jarret on 09/02/2025.
//

import SwiftUI
import AppIntents


@Observable
public class CoffeeTrackerViewModel {

    let intent: (any AppIntent)?

    public var coffeeCount: Int {
        controller.count
    }

    private let controller: CoffeeTrackController

    public init(controller: CoffeeTrackController, intent: (any AppIntent)? = nil) {
        self.controller = controller
        self.intent = intent
    }

    public func increment() {
        controller.perform(.increment)
    }

    public func decrement() {
        controller.perform(.decrement)
    }
}
