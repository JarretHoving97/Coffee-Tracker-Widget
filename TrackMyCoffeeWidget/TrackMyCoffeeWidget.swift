//
//  TrackMyCoffeeWidget.swift
//  TrackMyCoffeeWidget
//
//  Created by Jarret on 06/02/2025.
//

import CoffeeFramework
import WidgetKit
import SwiftUI
import AppIntents

struct CoffeeEntry: TimelineEntry {
    let date: Date
    let coffeeCount: Int
}

struct AddCoffeeIntent: AppIntent {
    static var title: LocalizedStringResource = "Add a Coffee"


    @State private var coffeeCount: Int = 0

    func perform() async throws -> some IntentResult {
        coffeeCount += 1
        return .result()
    }
}

struct CoffeeProvider: TimelineProvider {

    private var coffeeCount: Int = 0

    func placeholder(in context: Context) -> CoffeeEntry {
        CoffeeEntry(date: Date(), coffeeCount: coffeeCount)
    }

    func getSnapshot(in context: Context, completion: @escaping (CoffeeEntry) -> ()) {
        let entry = CoffeeEntry(date: Date(), coffeeCount: coffeeCount)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CoffeeEntry>) -> ()) {
        let entry = CoffeeEntry(date: Date(), coffeeCount: coffeeCount)
        let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60)))
        completion(timeline)
    }
}

struct CoffeeWidgetView: View {
    var entry: CoffeeEntry

    var body: some View {
        VStack {
            Text("☕ \(entry.coffeeCount)")
                .font(.largeTitle)
                .bold()

            Button(intent: AddCoffeeIntent()) {
                Label("Add", systemImage: "plus")
            }
            .buttonStyle(.borderedProminent)
        }
        .containerBackground(for: .widget) {  // 🛠️ Required for iOS 17+
            Color(.systemBackground)
        }
    }
}


struct TrackMyCoffeeWidget: Widget {
    let kind: String = "TrackMyCoffeeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CoffeeProvider()) { entry in
            CoffeeWidgetView(entry: entry)
        }
        .configurationDisplayName("My Coffee Tracker")
        .description("Tracks your daily coffee intake.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
struct TrackMyCoffeeWidget_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeWidgetView(entry: CoffeeEntry(date: Date(), coffeeCount: 5)) // Preview with 5 coffees
            .previewContext(WidgetPreviewContext(family: .systemSmall))  // Small widget preview
    }
}


