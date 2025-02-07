//
//  WaveAnimation.swift
//  Track My Coffee
//
//  Created by Jarret on 06/02/2025.
//

import SwiftUI

struct WaveAnimation: View {

    @State private var percent = 40.0
    @State private var waveOffset = Angle(degrees: 0)

    var body: some View {
        ZStack {
            Wave(offSet: Angle(degrees: waveOffset.degrees), percent: percent)
                .fill(Color.brown)
                .ignoresSafeArea(.all)

            InvisibleSlider(percent: $percent)
        }
    
        .onAppear {
            withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)
            }
        }
    }
}

struct Wave: Shape {

    var offSet: Angle
    var percent: Double

    var animatableData: Double {
        get { offSet.degrees }
        set { offSet = Angle(degrees: newValue) }
    }

    func path(in rect: CGRect) -> Path {
        var p = Path()

        let lowestWave = 0.02
        let highestWave = 1.00

        let newPercent = lowestWave + (highestWave - lowestWave) * (percent / 100)
        let waveHeight = 0.015 * rect.height
        let yOffSet = CGFloat(1 - newPercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
        let startAngle = offSet
        let endAngle = offSet + Angle(degrees: 360 + 10)

        p.move(to: CGPoint(x: 0, y: yOffSet + waveHeight * CGFloat(sin(offSet.radians))))

        for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
            let x = CGFloat((angle - startAngle.degrees) / 360) * rect.width
            p.addLine(to: CGPoint(x: x, y: yOffSet + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
        }

        p.addLine(to: CGPoint(x: rect.width, y: rect.height))
        p.addLine(to: CGPoint(x: 0, y: rect.height))
        p.closeSubpath()

        return p
    }
}

struct InvisibleSlider: View {

    @Binding var percent: Double

    var body: some View {
        GeometryReader { geo in
            let dragGesture = DragGesture(minimumDistance: 0)
                .onChanged { value in
                    let percent = 1.0 - Double(value.location.y / geo.size.height)
                    self.percent = max(0, min(100, percent * 100))
                }

            Rectangle()
                .opacity(0.001)
                .frame(width: geo.size.width, height: geo.size.height)
                .gesture(dragGesture)
        }
    }
}

struct WaveAnimation_Previews: PreviewProvider {
    static var previews: some View {
        WaveAnimation()
    }
}
