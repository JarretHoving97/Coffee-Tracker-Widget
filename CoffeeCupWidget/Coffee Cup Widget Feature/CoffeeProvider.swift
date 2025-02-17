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

    typealias Entry = CoffeeCupWidgetDataModel

    func placeholder(in context: Context) -> CoffeeCupWidgetDataModel {
        CoffeeCupWidgetDataModel(date: .now, coffees: controller.count)
    }

    func getSnapshot(in context: Context, completion: @escaping @Sendable (CoffeeCupWidgetDataModel) -> Void) {
        completion(CoffeeCupWidgetDataModel(date: .now, coffees: controller.count))
    }

    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<CoffeeCupWidgetDataModel>) -> Void) {
        let timeline = Timeline(entries: [CoffeeCupWidgetDataModel(date: .now, coffees: controller.count)], policy: .atEnd)
        completion(timeline)
    }
}
