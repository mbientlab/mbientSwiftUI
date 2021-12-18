// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public struct MiniMenuButton<Content: View>: View {

    private let content: () -> Content

    public init(@ViewBuilder _ menu: @escaping () -> Content) {
        self.content = menu
    }

#if os(macOS)
    public var body: some View {
        if #available(macOS 12.0, *) {
            Menu(content: content, label: { label })
            .fixedSize()
            .menuIndicator(.hidden)
            .menuStyle(.borderlessButton)
        } else {
            Menu(content: content, label: { label })
            .fixedSize()
            .menuStyle(.borderlessButton)
        }
    }
#endif

#if os(iOS)
    public var body: some View {
        if #available(iOS 15.0, *) {
            Menu(content: content, label: { label })
            .fixedSize()
            .menuIndicator(.hidden)
            .menuStyle(.borderlessButton)
        } else {
            Menu(content: content, label: { label })
            .fixedSize()
            .menuStyle(.borderlessButton)
        }
    }
#endif

    private var label: some View {
        SFSymbol.moreMenu.image()
            .font(.headline)
            .foregroundColor(.mySecondary)
    }
}
