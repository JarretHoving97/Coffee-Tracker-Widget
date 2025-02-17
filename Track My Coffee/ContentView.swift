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

        ScrollView {
            VStack {

                Text("42105 total amount of coffee's consumed.")
                    .frame(maxWidth: 200, alignment: .center)
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .bold()
                    .opacity(0.7)

                    .padding(.top, 100)


                HStack {
                    CoffeeCupIcon(
                       viewModel: CoffeeTrackerViewModel(
                           controller: CoffeeTrackController(
                               date: .now,
                               store: TrackerStores.coffeeTracker
                           )
                       )

                   )
                    .frame(width: 180, height: 180)

                    Spacer()
                }
                .padding(.top, 20)

                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        }

        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: CoffeeColors.goldenChic))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
