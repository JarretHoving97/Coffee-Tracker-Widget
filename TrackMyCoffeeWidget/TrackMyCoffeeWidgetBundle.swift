//
//  TrackMyCoffeeWidgetBundle.swift
//  TrackMyCoffeeWidget
//
//  Created by Jarret on 06/02/2025.
//

import WidgetKit
import SwiftUI

@main
struct TrackMyCoffeeWidgetBundle: WidgetBundle {
    var body: some Widget {
        TrackMyCoffeeWidget()
        TrackMyCoffeeWidgetControl()
        TrackMyCoffeeWidgetLiveActivity()
    }
}
