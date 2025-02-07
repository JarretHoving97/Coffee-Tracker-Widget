//
//  CoffeeTrackView.swift
//  Track My Coffee
//
//  Created by Jarret on 06/02/2025.
//

import SwiftUI

public struct CoffeeCupIcon: View {
    @State private var percent = 0.0
    @State private var waveOffset = Angle(degrees: 0)
    @AppStorage("coffeeCount", store: UserDefaults(suiteName: "group.com.jarretdevs.TrackMyCoffee")) private var coffeeCount: Int = 0
    @AppStorage("lastSavedDate", store: UserDefaults(suiteName: "group.com.jarretdevs.TrackMyCoffee")) private var lastSavedDate: String = ""

    public init() {}

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

            VStack {
                Text(coffeeCount.description)
                    .font(.largeTitle)
                    .bold()

                Button {
                    addCoffee()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.black)
                }
            }
            .onAppear {
                checkForNewDay()
            }
        }
    }

    private func addCoffee() {
        coffeeCount += 1
        let calc = Double(coffeeCount) / 10.0 * 100
        percent = min(calc, 100)

        withAnimation(.linear(duration: 1.0).repeatCount(2, autoreverses: false)) {
            waveOffset = Angle(degrees: 360)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            waveOffset = Angle(degrees: 0)
        }

        saveDate()
    }

    private func saveDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        lastSavedDate = formatter.string(from: Date())
    }

    private func checkForNewDay() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = formatter.string(from: Date())

        if today != lastSavedDate {
            coffeeCount = 0
            saveDate()
        } else {
            let calc = Double(coffeeCount) / 10.0 * 100
            percent = min(calc, 100)
        }
    }
}

// Deksel
struct LidShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(in: rect, cornerSize: CGSize(width: 5, height: 5))
        return path
    }
}

// Beker
struct CupShape: Shape {
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
    CoffeeCupIcon()
}
