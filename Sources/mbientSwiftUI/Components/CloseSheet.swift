// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public struct CloseSheet: ViewModifier {

    public init() { }

    public func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            CloseButton()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top)
                .padding(.horizontal)

            content
                .padding()
        }
    }

    struct CloseButton: View {
        @Environment(\.presentationMode) private var present
        var body: some View {
            Button("Done") { present.wrappedValue.dismiss() }
        }
    }
}
