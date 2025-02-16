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
            kind: "CoffeeCupWidget",
            provider: CoffeeProvider()
        ) { order in

            CoffeeCupView(entry: order)
        }
        .configurationDisplayName("Coffee counter")
                .description("Keep track of your daily coffee consumption.")
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

            VStack(alignment: .leading, spacing: 0) {
                Spacer()

                VStack(alignment: .center, spacing: 0) {


                    Button(intent: AddCoffeeIntent()) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(Color(uiColor: CoffeeColors.goldenChic)
                            )
                        }


                    Rectangle()
                        .frame(height: 1.3)
                        .foregroundStyle(Color(uiColor: CoffeeColors.goldenChic)
                        )


                    Button(intent: DecrementCoffeeIntent()) {
                        Image(systemName: "minus")
                            .frame(width: 19, height: 2)
                            .padding(.vertical, 4)
                            .foregroundStyle(Color(uiColor: CoffeeColors.goldenChic)
                            )

                    }


                }
                .frame(width: 24.7, height: 49.4)
                .background(.black)
                .cornerRadius(8)
            }

            .frame(width: 24.7, height: 79.4)

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
