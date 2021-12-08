// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public struct RefreshButton: View {

    public init(help: String, didTap: @escaping () -> Void) {
        self.didTap = didTap
        self.helpAccessibilityLabel = help
    }

    public var didTap: () -> Void
    public var helpAccessibilityLabel: String

    public var body: some View {
        Button { didTap() } label: {
            Image(systemName: SFSymbol.refresh.rawValue)
                .accessibilityLabel(SFSymbol.refresh.accessibilityDescription)
        }
        .help(helpAccessibilityLabel)
        .accessibilityLabel(helpAccessibilityLabel)
        .accessibilityAddTraits(.isButton)
    }
}
