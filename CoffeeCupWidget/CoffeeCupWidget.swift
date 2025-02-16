//
//  CoffeeCupWidget.swift
//  CoffeeCupWidget
//
//  Created by Jarret on 09/02/2025.
//

import WidgetKit
import SwiftUI
import CoffeeFramework

struct CoffeesConsumedEntry: TimelineEntry {
    let date: Date
    let coffees: Int
}

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


struct LastOrderView: View {
    let consumed: CoffeesConsumedEntry

    init(_ consumed: CoffeesConsumedEntry) {
        self.consumed = consumed
    }

    var body: some View {
        Text(consumed.coffees.description)

        HStack {
            Button(intent: AddCoffeeIntent()) {
                Image(systemName: "plus")
            }
        }
        .containerBackground(for: .widget) {
               Color.yellow
           }
    }
}

struct CoffeeCupWidget: Widget {
    var body: some WidgetConfiguration {

        StaticConfiguration(
            kind: "widget",
            provider: CoffeeProvider()
        ) { order in
                LastOrderView(order)
            }
        .configurationDisplayName("Coffee Cup Widget")
    }
}


#Preview("Small", as: .systemSmall) {
    CoffeeCupWidget()

} timelineProvider: {
    CoffeeProvider()
}
