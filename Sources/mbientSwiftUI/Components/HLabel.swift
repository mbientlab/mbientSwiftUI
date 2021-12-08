// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

/// Aligns to SubtitleWK when provided a subtitleWidth and the coalescing parent uses .onPreferenceChange to update state
public struct HLabel<Content: View>: View {

    public init(_ subtitle: String,
         secondary: Color = .secondary,
         align toSubtitleWidth: CGFloat? = nil,
         spacing: CGFloat = 8,
         _ view: @escaping () -> Content) {
        self.subtitle = subtitle
        self.spacing = spacing
        self.view = view
        self.secondaryColor = secondary
        self.subtitleWidth = toSubtitleWidth
    }

    public init(_ subtitle: String,
                item: String,
                secondary: Color = .secondary,
                align toSubtitleWidth: CGFloat? = nil,
                spacing: CGFloat = 8
    ) where Content == Text {
        self.subtitle = subtitle
        self.spacing = spacing
        self.view = { Text(item) }
        self.secondaryColor = secondary
        self.subtitleWidth = toSubtitleWidth
    }


    var subtitle: String
    var view: () -> Content
    var secondaryColor: Color
    var subtitleWidth: CGFloat?
    var spacing: CGFloat

    public var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: spacing) {
            Text(subtitle)
                .foregroundColor(secondaryColor)
                .font(.subheadline)
                .reportMaxWidth(to: SubtitleWK.self)
                .frame(minWidth: subtitleWidth, alignment: .topLeading)

            view()
                .font(.body.bold().monospacedDigit())
        }
    }
}

