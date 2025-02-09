//
//  CoffeeTrackerViewModel.swift
//  Track My Coffee
//
//  Created by Jarret on 09/02/2025.
//

@Observable
public class CoffeeTrackerViewModel {

    public var coffeeCount: Int {
        controller.count
    }

    private let controller: CoffeeTrackController

    public init(controller: CoffeeTrackController) {
        self.controller = controller
    }

    public func increment() {
        controller.perform(.increment)
    }

    public func decrement() {
        controller.perform(.decrement)
    }
}
