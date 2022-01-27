// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI
import MetaWear
import MetaWearSync

public struct FlashingLEDShine: View {

    public init(emulator: MWLED.Flash.Emulator, diameter: CGFloat) {
        self.diameter = diameter
        self.ledEmulator = emulator
    }

    @ObservedObject public var ledEmulator: MWLED.Flash.Emulator
    public var diameter: CGFloat

    public var body: some View {
        ZStack {
            dot.blur(radius: diameter * 0.4)
            dot.blur(radius: diameter * 0.15).opacity(0.5)
        }
    }

    private var dot: some View {
        Circle()
            .foregroundColor(.init(ledEmulator.color))
            .opacity(ledEmulator.ledIsOn ? 1 : 0)
            .animation(.linear(duration: 0.05), value: ledEmulator.ledIsOn)
            .frame(width: diameter, height: diameter)
    }
}
