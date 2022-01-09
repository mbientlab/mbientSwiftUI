// Copyright 2022 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public struct SoftSpotlight: View {

    public init(color: Color, radius: CGFloat) {
        self.color = color
        self.radius = radius
    }

    var color: Color
    var radius: CGFloat

    @Environment(\.colorScheme) private var colorScheme

    public var body: some View {
        RadialGradient(
            gradient: .init(colors: [
                color.opacity(colorScheme == .light ? 0.3 : 0.35),
                color.opacity(0)
            ]),
            center: .center, startRadius: 0, endRadius: radius)
    }
}
