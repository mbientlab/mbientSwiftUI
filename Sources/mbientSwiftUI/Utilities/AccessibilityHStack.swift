// Copyright 2022 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public struct AccessibilityHStack<Content:View>: View {

    public init(vstackAlign: HorizontalAlignment, vSpacing: CGFloat? = nil, hstackAlign: VerticalAlignment, hSpacing: CGFloat? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.vstackAlign = vstackAlign
        self.vSpacing = vSpacing
        self.hstackAlign = hstackAlign
        self.hSpacing = hSpacing
        self.content = content
    }

    var vstackAlign: HorizontalAlignment
    var vSpacing: CGFloat?
    var hstackAlign: VerticalAlignment
    var hSpacing: CGFloat?

    @ViewBuilder var content: () -> Content
    @Environment(\.sizeCategory) private var typeSize
    var isAccessibilitySize: Bool { typeSize.isAccessibilityCategory }

    public var body: some View {
        if isAccessibilitySize {
            VStack(alignment: vstackAlign, spacing: vSpacing, content: content)
        } else {
            HStack(alignment: hstackAlign, spacing: hSpacing, content: content)
        }
    }
}
