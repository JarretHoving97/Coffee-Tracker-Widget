//
//  CoffeeCupWidgetView.swift
//  Track My Coffee
//
//  Created by Jarret on 17/02/2025.
//

import SwiftUI
import AppIntents

public struct CoffeeCupWidgetView: View {

    let model: CoffeeCupWidgetDataModel

    let buttonType: CoffeeCupWidgetButtonType

    public init(model: CoffeeCupWidgetDataModel, buttonType: CoffeeCupWidgetButtonType) {
        self.model = model
        self.buttonType = buttonType
    }

    public var body: some View {

        VStack(alignment: .center, spacing: 20) {

            Spacer()
            ZStack {
                ZStack {
                    Wave(
                        offSet: Angle(degrees: 360),
                        percent: model.percentage
                    )
                    .fill(Color(uiColor: CoffeeColors.mocha))
                    .ignoresSafeArea(.all)
                    .clipShape(CupShape())
                    .offset(y: 2)
                    .animation(.linear(duration: 1.0), value: model.percentage)
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
            .padding(.bottom, -10)

            buttonsView

            .overlay(RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 2.6))


        }
        .padding(.bottom, 10)
    }
}



extension CoffeeCupWidgetView {

    public enum CoffeeCupWidgetButtonType {
        case appIntent(onIncrement: any AppIntent, onDecrement: any AppIntent)
        case action(onIncrement: () -> Void, onDecrement: () -> Void)
    }

    private var buttonsView: some View {
        HStack(alignment: .center) {
            switch buttonType {
            case .appIntent(let onIncrement, let onDecrement):
                Button(intent: onIncrement) {
                    Image(systemName: "plus")
                        .foregroundStyle(Color.black)
                }
                .buttonStyle(PlainButtonStyle())
                .frame(width: 20, height: 20)
                .padding(.leading, 10)

                Spacer()

                Rectangle()
                    .frame(width: 2.6)
                    .foregroundStyle(Color.black)

                Spacer()

                Button(intent: onDecrement) {
                    Image(systemName: "minus")
                        .foregroundStyle(Color.black)
                }
                .buttonStyle(PlainButtonStyle())
                .frame(width: 20, height: 20)
                .padding(.trailing, 10)

            case .action(let onIncrement, let onDecrement):
                Button(action: { onIncrement() }) {
                    Image(systemName: "plus")
                        .foregroundStyle(Color.black)
                }
                .buttonStyle(PlainButtonStyle())
                .frame(width: 20, height: 20)
                .padding(.leading, 10)

                Spacer()

                Rectangle()
                    .frame(width: 2.6)
                    .foregroundStyle(Color.black)

                Spacer()

                Button(action: { onDecrement() }) {
                    Image(systemName: "minus")
                        .foregroundStyle(Color.black)
                }
                .buttonStyle(PlainButtonStyle())
                .frame(width: 20, height: 20)
                .padding(.trailing, 10)
            }
        }
        .frame(height: 24)
        .frame(width: 100)
        .overlay(RoundedRectangle(cornerRadius: 12)
            .stroke(Color.black, lineWidth: 2.6))
    }


    var countView: some View {
        ZStack {
            // Black text (always fully visible)
            Text("\(model.coffees)")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
                .zIndex(1)

            // White text (masked to follow coffee level)
            Text("\(model.coffees)")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color(uiColor: CoffeeColors.goldenChic))
                .mask(
                    Wave(
                        offSet: Angle(degrees: 360),
                        percent: model.percentage
                    )
                    .frame(width: 70, height: 80)
                    .offset(y: 2)
                )
                .zIndex(3)
        }
        .contentTransition(.numericText())
    }
}
