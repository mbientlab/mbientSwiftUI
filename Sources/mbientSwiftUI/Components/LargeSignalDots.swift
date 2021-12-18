// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI
import MetaWear

public struct LargeSignalDots: View {

    public init(color: Color, dotSize: CGFloat = 15, spacing: CGFloat = 4) {
        self.dotSize = dotSize
        self.color = color
        self.spacing = spacing
    }


    @Environment(\.signalLevel) private var signal: SignalLevel
    private var dotSize: CGFloat
    private var spacing: CGFloat
    private var color: Color

    private var width: CGFloat {
        SignalLevel.maxBarsCG * (dotSize + spacing) - spacing
    }

    public var body: some View {
        HStack(spacing: spacing) {
            ForEach(SignalLevel.dots) { dot in
                if dot <= signal { activeDot }
                else { inactiveDot }
            }
        }
        .frame(width: width, height: dotSize)
        .foregroundColor(color)
        .animation(.easeOut, value: signal)
    }

    private var inactiveDot: some View {
        Circle()
            .strokeBorder(lineWidth: 2, antialiased: true)
            .frame(width: dotSize, height: dotSize)
            .opacity(0.5)
    }

    private var activeDot: some View {
        Circle()
            .frame(width: dotSize, height: dotSize)
    }
}
