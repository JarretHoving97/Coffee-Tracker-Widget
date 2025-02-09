//
//  CoffeeTrackView.swift
//  Track My Coffee
//
//  Created by Jarret on 06/02/2025.
//

import SwiftUI
import AppIntents


public struct CoffeeCupIcon: View {

    @State private var percent = 0.0
    @State private var waveOffset = Angle(degrees: 0)

    private var viewModel: CoffeeTrackerViewModel

    init(viewModel: CoffeeTrackerViewModel) {
        self.viewModel = viewModel
        self.percent = percent
        self.waveOffset = waveOffset
    }

    public var body: some View {
        HStack {
            ZStack {
                ZStack {
                    Wave(
                        offSet: Angle(degrees: waveOffset.degrees),
                        percent: percent
                    )
                    .fill(Color.brown)
                    .ignoresSafeArea(.all)
                    .clipShape(CupShape())
                    .offset(y: 4)
                }
                .frame(width: 75, height: 96)

                // Beker
                CupShape()
                    .stroke(Color.black, lineWidth: 6)
                    .frame(width: 80, height: 100)

                // Deksel
                LidShape()
                    .stroke(Color.black, lineWidth: 6)
                    .frame(width: 90, height: 20)
                    .offset(y: -60)
            }

            VStack(alignment: .leading) {
                Text(viewModel.coffeeCount.description)
                    .font(.largeTitle)
                    .bold()

                HStack(spacing: 20) {
                    Button {
                        addCoffee()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.black)
                    }

                    Button {
                        removeCoffee()
                    } label: {
                        Image(systemName: "minus")
                            .resizable()
                            .frame(width: 20, height: 2)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        .onAppear {
            loadView()
        }
    }

    private func removeCoffee() {
        DispatchQueue.main.asyncAfter(deadline: .now() ) {
            viewModel.decrement()
        }

        loadView()
    }

    private func addCoffee() {

        DispatchQueue.main.asyncAfter(deadline: .now() ) {
            viewModel.increment()
        }

        loadView()
    }

    public func loadView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let calc = Double(viewModel.coffeeCount) / 10.0 * 100
            percent = min(calc, 100)
        }
        withAnimation(
            .linear(duration: 1.0).repeatCount(2, autoreverses: false)
        ) {
            waveOffset = Angle(degrees: 360)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            waveOffset = Angle(degrees: 0)
        }
    }
}

fileprivate struct LidShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(in: rect, cornerSize: CGSize(width: 5, height: 5))
        return path
    }
}

fileprivate struct CupShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX + 15, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - 15, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - 5, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + 5, y: rect.minY))
        path.closeSubpath()
        return path
    }
}


#Preview {
    CoffeeCupIcon(
        viewModel: CoffeeTrackerViewModel(
            controller: CoffeeTrackController(
                date: Date.now,
                store: TrackerStore(
                    defaults: UserDefaults(suiteName: "preview")!,
                    storageKey: "key"
                )
            )
        )
    )
}
