// Copyright 2022 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public extension Gradient {

    static func maskingGradient(affectedRatio: CGFloat = 0.39, diameter: CGFloat, reversed: Bool = false) -> RadialGradient {
        RadialGradient(
            gradient: .init(colors: [
                .black.opacity(reversed ? 1 : 0),
                .black.opacity(reversed ? 0 : 1)
            ]),
            center: .center,
            startRadius: diameter * affectedRatio,
            endRadius: diameter)
    }
}

public struct MaskedZStack<Content: View>: View {

    public init(diameter: CGFloat, @ViewBuilder content: @escaping () -> Content) {
        self.diameter = diameter
        self.content = content
    }

    var diameter: CGFloat
    @ViewBuilder var content: () -> Content

    public var body: some View {
        if #available(iOS 15.0, macOS 12.0, *) {
            ZStack(content: content)
            .mask(alignment: .center) { Gradient.maskingGradient(diameter: diameter) }
        } else {
            ZStack(content: content)
            .mask(Gradient.maskingGradient(diameter: diameter))
        }
    }
}

public struct DigitalVignette: View {

    public init(fontSize: CGFloat = 6, background: Color, blendMode: BlendMode) {
        self.fontSize = fontSize
        self.background = background
        self.blendMode = blendMode
    }


    var fontSize: CGFloat = 6
    var spacing: CGFloat { fontSize / 4 }
    var background: Color
    var blendMode: BlendMode

    public var body: some View {
        binary
    }

    var binary: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height + fontSize * 4
            let rowCount = Int(width / (fontSize + spacing)) + 1
            let glyphCount = Int(height / fontSize)
            let glyphs = makePattern(length: glyphCount)
            let diameter = max(geo.size.height, geo.size.width) * (idiom == .iPad ? 1.12 : 1)

            MaskedZStack(diameter: diameter) {
                background

                HStack(alignment: .firstTextBaseline, spacing: spacing) {
                    ForEach(0..<rowCount) { rowIndex in
                        Text(String(glyphs.shuffled()))
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.system(size: fontSize, weight: .light, design: .monospaced))
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .truncationMode(.tail)
                            .frame(width: fontSize, height: height)
                            .opacity(rowIndex % 2 == 0 ? 0.5 : 1)
                            .opacity(rowIndex % 7 == 0 ? 0.5 : 1)
                    }
                }
                .offset(y: -fontSize * 2)
                .frame(width: width, height: height)
                .edgesIgnoringSafeArea(.all)
                .blendMode(blendMode)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }

    func makePattern(length: Int) -> String {
        let count = (length / Self.binaryPatternLength) + 1
        let base = Substring(Self.binaryPattern)
        let overfilled = Array(repeating: base, count: count)
        return overfilled.joined()
    }

    static let binaryPattern = "01010101010100101010101010101010101011010101000101010101101010101010101010"
    static let binaryPatternLength = binaryPattern.count
}
