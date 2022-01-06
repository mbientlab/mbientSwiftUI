// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

/// Crashes if Environment does not have a Namespace
///
struct MatchedGeometryColorView: ViewModifier {

    var color: Color

    func body(content: Content) -> some View {
        Modified(content: content, color: color)
    }

    struct Modified: View {
        @Environment(\.namespace) var namespace
        var content: Content
        var color: Color

        #if os(iOS)
        @Environment(\.verticalSizeClass) private var vRotation
        #endif

        private var id: Int {
            #if os(macOS)
            color.hashValue
            #elseif os(iOS)
            color.hashValue / (vRotation?.hashValue ?? 0)
            #endif
        }

        var body: some View {
            content
                .background(
                    color
                        .edgesIgnoringSafeArea(.all)
                        .matchedGeometryEffect(
                            id: id,
                            in: namespace!,
                            properties: .frame,
                            anchor: .center,
                            isSource: idiom.is_Mac ? true : false
                        )
                )
        }
    }
}

public extension View {

    /// Crashes if Environment does not have a Namespace
    ///
    func backgroundToEdges(_ color: Color = .defaultSystemBackground) -> some View {
        modifier(MatchedGeometryColorView(color: color))
            .environment(\.reverseOutColor, color)
    }

    /// Crashes if Environment does not have a Namespace. For views where all system components should be reversed out (e.g., mandate dark mode), but popup menus should retain system appearance.
    ///
    func backgroundToEdges(reversedBuiltIns color: Color = .defaultSystemBackground) -> some View {
        backgroundToEdges(color)
        // Workaround for macOS as some Menu and built-in components do not properly accept reverse-out shading
            .colorScheme(.dark)
        // Setting this would force system dialogs into dark mode (undesired).
        //  .preferredColorScheme(.dark)

    }
}
