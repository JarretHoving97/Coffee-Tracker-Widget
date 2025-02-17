//
//  CoffeeCupWidget.swift
//  CoffeeCupWidget
//
//  Created by Jarret on 09/02/2025.
//

import WidgetKit
import SwiftUI
import CoffeeFramework

struct CoffeeCupWidget: Widget {

    var body: some WidgetConfiguration {

        StaticConfiguration(
            kind: "CoffeeCupWidget",
            provider: CoffeeProvider()
        ) { entry in

            CoffeeCupWidgetView(
                model: entry,
                buttonType: .appIntent(
                    onIncrement: AddCoffeeIntent(),
                    onDecrement: DecrementCoffeeIntent()
                )
            )
            .containerBackground(for: .widget) {
                Color(uiColor: CoffeeColors.goldenChic)
            }
        }
        .configurationDisplayName("Coffee counter")
        .description("Keep track of your daily coffee consumption.")
    }
}

#Preview("Small", as: .systemSmall) {
    CoffeeCupWidget()

} timelineProvider: {
    CoffeeProvider()
}

