//
//  ContentView.swift
//  Track My Coffee
//
//  Created by Jarret on 06/02/2025.
//

import SwiftUI
import CoffeeFramework


// Voorvertoning
struct ContentView: View {

    var body: some View {
        CoffeeCupIcon(
            viewModel: CoffeeTrackerViewModel(controller: CoffeeTrackController(date: .now, store: TrackerStores.coffeeTracker))
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
