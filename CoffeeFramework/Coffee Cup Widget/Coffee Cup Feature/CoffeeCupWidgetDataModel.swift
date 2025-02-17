//
//  CoffeeCupWidgetDataModel.swift
//  Track My Coffee
//
//  Created by Jarret on 17/02/2025.
//

import Foundation

public struct CoffeeCupWidgetDataModel: Equatable {

    public let date: Date
    public let coffees: Int

    public init(date: Date, coffees: Int) {
        self.date = date
        self.coffees = coffees
    }

    public var percentage: Double {
        let calc = Double(coffees) / 10.0 * 100
        let percent = min(calc, 100)

        return percent
    }
}
