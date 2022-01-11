// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI
import CoreBluetooth

public struct ConnectionIcon: View {

    public init(color: Color? = .myPrimary, size: Font.Config = .systemHeadline) {
        self.color = color
        self.size = size
    }

    private var size: Font.Config
    private var color: Color?
    @Environment(\.connectionState) private var state: CBPeripheralState

    public var body: some View {
        (state == .connected
         ? SFSymbol.connected.image()
         : SFSymbol.disconnected.image() )
            .adaptiveFont(size)
            .foregroundColor(color)
            .animation(.easeOut, value: state)
            .animation(.easeOut, value: color)
            .help(Text(state == .connected ? "Connected" : "Disconnected"))
    }
}
