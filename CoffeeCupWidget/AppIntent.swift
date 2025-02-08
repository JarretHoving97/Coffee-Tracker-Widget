//
//  AppIntent.swift
//  CoffeeCupWidget
//
//  Created by Jarret on 08/02/2025.
//

import WidgetKit
import AppIntents
import SwiftUI


struct LogCoffeIntent: WidgetConfigurationIntent {

    @AppStorage("coffeeCount", store: UserDefaults(suiteName: "group.com.jarretdevs.TrackMyCoffee")) private var coffeeCount: Int = 0
    @AppStorage("lastSavedDate", store: UserDefaults(suiteName: "group.com.jarretdevs.TrackMyCoffee")) private var lastSavedDate: String = ""


    static var title: LocalizedStringResource = "Log consumed Coffee"

    static var description = IntentDescription("Increments Coffee drank count")


    func perform() async throws -> some IntentResult {
        return .result(value: addCoffee())
    }

    private func addCoffee() -> Int {

        DispatchQueue.main.asyncAfter(deadline: .now() ) {
            coffeeCount += 1
        }
        saveDate()

        return coffeeCount
    }

    private func saveDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        lastSavedDate = formatter.string(from: Date())
    }

}
