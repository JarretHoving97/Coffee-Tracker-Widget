//
//  CoffeeProvider.swift
//  Track My Coffee
//
//  Created by Jarret on 16/02/2025.
//

import WidgetKit
import CoffeeFramework

struct CoffeeProvider: TimelineProvider {

    private let controller = CoffeeTrackController(date: .now, store: TrackerStores.coffeeTracker)

    typealias Entry = CoffeesConsumedEntry

    func placeholder(in context: Context) -> CoffeesConsumedEntry {
        CoffeesConsumedEntry(date: .now, coffees: controller.count)
    }

    func getSnapshot(in context: Context, completion: @escaping @Sendable (CoffeesConsumedEntry) -> Void) {
        completion(CoffeesConsumedEntry(date: .now, coffees: controller.count))
    }

    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<CoffeesConsumedEntry>) -> Void) {
        let timeline = Timeline(entries: [CoffeesConsumedEntry(date: .now, coffees: controller.count)], policy: .atEnd)
        completion(timeline)
    }
}
