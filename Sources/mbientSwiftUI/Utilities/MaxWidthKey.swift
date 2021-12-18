// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public struct SubtitleWK: MaxWidthKey {
    public static var defaultValue: CGFloat = 0
}

// MARK: - Preference Key

public protocol MaxWidthKey: PreferenceKey where Value == CGFloat {
    static var defaultValue: CGFloat { get }
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat)
}

public extension MaxWidthKey {
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

public extension View {
    func reportMaxWidth<K: MaxWidthKey>(to key: K.Type) -> some View {
        modifier(DetermineMaxWidth(key: key))
    }
}

public struct DetermineMaxWidth<K: MaxWidthKey>: ViewModifier {
    public var key: K.Type

    public init(key: K.Type) {
        self.key = key
    }

    public func body(content: Content) -> some View {
        content.background(
            GeometryReader { proxy in
                Color.clear
                    .anchorPreference(key: key, value: .bounds) { anchor in
                        proxy[anchor].size.width
                    }
            }
        )
    }
}

public extension View {
    func reportWidth(to width: Binding<CGFloat>) -> some View {
        modifier(DetermineWidth(width))
    }
}

public struct DetermineWidth: ViewModifier {
    @Binding var width: CGFloat

    public init(_ width: Binding<CGFloat>) {
        _width = width
    }

    public func body(content: Content) -> some View {
        content.background(
            GeometryReader { proxy in
                Color.clear
                    .onChange(of: proxy.size.width) { width = $0 }
            }
        )
    }
}
