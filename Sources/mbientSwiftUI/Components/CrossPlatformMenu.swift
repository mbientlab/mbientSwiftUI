// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public struct CrossPlatformMenu<L: Listable>: View {

    public init(selected: Binding<L>,
                options: [L],
                labelFont: Font? = nil) {
        _selected = selected
        self.options = options
        self.labelFont = labelFont
    }

    @Binding public var selected: L
    public let options: [L]
    public var labelFont: Font? = nil

    public var body: some View {
        menu
    }

    private var menu: some View {
        Menu {
            ForEach(options) { option in
                Button(action: { selected = option }, label: { Text(option.label) })
            }
        } label: {
            Text(selected.label)
                .font(labelFont)
        }
    }

    private var picker: some View {
        Picker(selection: $selected) {
            ForEach(options) { option in
                Text(option.label).id(option).tag(option)
            }
        } label: {
            Text("")
        }
        .pickerStyle(.menu)
    }
}
