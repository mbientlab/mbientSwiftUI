// Copyright 2022 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public struct FlipView<Heads: View, Tails: View>: View {

    public init(up: Heads,
                down: Tails,
                showFaceUp: Bool) {
        self.up = up
        self.down = down
        self.showFaceUp = showFaceUp
    }

    var up: Heads
    var down: Tails
    var showFaceUp: Bool
    @State private var isFaceUp = true

    public var body: some View {
        ZStack {
            if showFaceUp { upView } else { downView }
        }
        .rotation3DEffect(
            .degrees(showFaceUp ? 180 : 0),
            axis: (x: 0, y: 1, z: 0.0)
        )
        .overlay(FlipReporter(isFaceUp: $isFaceUp,
                              angle: showFaceUp ? 180 : 0))
        .animation(.easeInOut, value: showFaceUp)
    }

    private var upView: some View {
        up.rotation3DEffect(.degrees(isFaceUp ? -180 : 0),
                            axis: (x: 0, y: 1, z: 0.0))
    }

    private var downView: some View {
        down
    }
}

public struct FlipReporter: Shape {

    public init(isFaceUp: Binding<Bool>, angle: Double) {
        self.angle = angle
        _isFaceUp = isFaceUp
    }

    @Binding var isFaceUp: Bool
    var angle: Double

    public var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }

    public func path(in rect: CGRect) -> Path {
        DispatchQueue.main.async {
            self.isFaceUp = self.angle >= 90 && self.angle < 270
        }
        return Path()
    }
}
