// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI
import MetaWear
import MetaWearSync

public struct MetaWearWithLED: View {

    public init(width: CGFloat, height: CGFloat, ledEmulator: MWLED.Flash.Pattern.Emulator = .init(preset: .zero)) {
        self.width = width
        self.height = height
        self.ledEmulator = ledEmulator
    }

    private var ledEmulator: MWLED.Flash.Pattern.Emulator = .init(preset: .zero)
    @Environment(\.isDimmed) private var isDimmed
    @Environment(\.isHovered) private var isHovering
    @Environment(\.isDropTarget) private var isDropping
    @Environment(\.metaWearModel) private var model
    private var width: CGFloat
    private var height: CGFloat

    public var body: some View {
        model.image.image()
            .resizable()
            .aspectRatio(280/340, contentMode: .fit)
            .brightness(isHovering || isDropping ? 0.03 : 0)
            .overlay(FlashingLEDShine(emulator: ledEmulator, diameter: ledDiameter)
                        .offset(x: width * 0.01, y: height * 0.22), alignment: .top)
            .frame(width: width, height: height, alignment: .bottom)
            .opacity(isDimmed ? 0.5 : 1)
            .animation(.easeOut, value: isDimmed)
            .animation(.spring(), value: isHovering)
            .animation(.spring(), value: isDropping)
    }

    private var ledDiameter: CGFloat { min(height, width) * 0.2 }
}
