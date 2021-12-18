// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public struct ProgressSpinner: View {

    public init() { }

    public var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            #if os(macOS)
            .controlSize(.small)
            #endif
    }
}
