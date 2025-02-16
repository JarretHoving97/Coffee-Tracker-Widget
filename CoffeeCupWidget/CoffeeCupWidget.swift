//
//  CoffeeCupWidget.swift
//  CoffeeCupWidget
//
//  Created by Jarret on 09/02/2025.
//

import WidgetKit
import SwiftUI
import CoffeeFramework

struct CoffeesConsumedEntry: TimelineEntry, Equatable {

    let date: Date
    let coffees: Int

    var percentage: Double {
        let calc = Double(coffees) / 10.0 * 100
        let percent = min(calc, 100)

        return percent
    }
}


struct CoffeeTrackerView: View {
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

            CoffeeCupView(entry: order)
        }
        .configurationDisplayName("Coffee counter")
    }
}


struct CoffeeCupView: View {


    let entry: CoffeesConsumedEntry

    var body: some View {

        HStack {

            Spacer()

            ZStack {
                ZStack {
                    Wave(
                        offSet: Angle(degrees: 360),
                        percent: entry.percentage
                    )
                    .fill(Color(uiColor: CoffeeColors.mocha))
                    .ignoresSafeArea(.all)
                    .clipShape(CupShape())
                    .offset(y: 2)
                    .animation(.linear(duration: 1.0), value: entry.percentage)
                }
                .frame(width: 70, height: 80)

                countView

                // Beker
                CupShape()
                    .stroke(Color.black, lineWidth: 4)
                    .frame(width: 70, height: 80)

                // Deksel
                LidShape()
                    .stroke(Color.black, lineWidth: 4)
                    .frame(width: 70, height: 15)
                    .offset(y: -47)
            }

            Spacer()

            VStack(alignment: .center) {

                Button(intent: AddCoffeeIntent()) {
                    Image(systemName: "plus")
                        .foregroundStyle(.black)
                }

                Button(intent: DecrementCoffeeIntent()) {
                    Image(systemName: "minus")
                        .padding(.vertical, 5)
                        .foregroundStyle(.black)
                        .tint(.black)
                }
            }

        }
        .padding(.bottom, -20)
        .containerBackground(for: .widget) {
            
            Color(uiColor: CoffeeColors.goldenChic)
        }

    }

    var countView: some View {
        ZStack {
            // Black text (always fully visible)
            Text("\(entry.coffees)")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
                .zIndex(1)

            // White text (masked to follow coffee level)
            Text("\(entry.coffees)")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color(uiColor: CoffeeColors.goldenChic))
                .mask(
                    Wave(
                        offSet: Angle(degrees: 360),
                        percent: entry.percentage
                    )
                    .frame(width: 70, height: 80)
                    .offset(y: 2)
                )
                .zIndex(3)
        }
        .contentTransition(.numericText())
    }
}


#Preview("Small", as: .systemSmall) {
    CoffeeCupWidget()

} timelineProvider: {
    CoffeeProvider()
}
