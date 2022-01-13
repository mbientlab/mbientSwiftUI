// Copyright 2022 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public struct ScrollFadeMask: View {

    public enum Edge {
        case top, bottom
    }

    public init(edge: Edge,
                enabled: Bool = true,
                scrollBarInset: CGFloat = 8,
                height: CGFloat = CGFloat(macOS: 25, iPad: 45, iOS: 45)
    ) {
        self.edge = edge
        self.enabled = enabled
        self.scrollBarInset = scrollBarInset
        self.height = height
    }
    private let height: CGFloat
    private let scrollBarInset: CGFloat
    private let enabled: Bool
    private let edge: Edge
    private var start: UnitPoint { edge == .bottom ? .top    : .bottom }
    private var end:   UnitPoint { edge == .bottom ? .bottom : .top }

    public var body: some View {
        VStack(spacing: 0) {
            if edge == .bottom { Color.white }
            fade
            if edge == .top { Color.white }
        }
        .opacity(enabled ? 1 : 0)
    }

    private var fade: some View {
        HStack(alignment: .bottom, spacing: 0) {

            LinearGradient(gradient: .init(colors: [
                .white,
                .white.opacity(0)
            ]), startPoint: start, endPoint: end)

            Color.white.frame(width: scrollBarInset)

        }.frame(height: height)
    }
}
