// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public struct CrossPlatformStylizedMenu<L: Listable>: View {

    public init(selected: Binding<L>,
                options: [L],
                labelFont: Font? = nil,
                labelColor: Color,
                staticLabel: String? = nil) {
        _selected = selected
        self.options = options
        self.labelFont = labelFont
        self.labelColor = labelColor
        self.staticLabel = staticLabel
    }

    @Binding public var selected: L
    public let options: [L]
    public var labelFont: Font? = nil
    public var labelColor: Color
    public var staticLabel: String?

    public var body: some View {
        menu
#if os(macOS)
        .alignmentGuide(HorizontalAlignment.center) { $0[HorizontalAlignment.center] + 5 }
        .menuStyle(BorderlessButtonMenuStyle(showsMenuIndicator: false))
        .background(tickMark.alignmentGuide(.trailing) { $0[.leading] + 3 }, alignment: .trailing)
#else
        .menuStyle(.borderlessButton)
#endif
    }

    private var menu: some View {
        Menu {
            ForEach(options) { option in
                Button(action: { selected = option }, label: { Text(option.label) })
            }
        } label: {
            Text(staticLabel ?? selected.label)
                .foregroundColor(labelColor)
                .font(labelFont)
                .accessibilityLabel(selected.label)
        }
    }

    private var tickMark: some View {
        Text("􀆈")
            .font(labelFont)
            .scaleEffect(0.7)
            .foregroundColor(labelColor)
            .accessibilityHidden(true)
    }
}
