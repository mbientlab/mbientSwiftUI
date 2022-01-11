// Copyright 2022 MbientLab Inc. All rights reserved. See LICENSE.MD.
#if canImport(AppKit)
import AppKit
import SwiftUI

extension NSFont {

    static func adaptive(_ config: Font.Config) -> NSFont {
        config.getFont(overrideFace: nil, scaledSize: config.size) // SC
    }
}

extension Font.Config {

    /// Construct a configured Font instance
    func getFont(overrideFace: Font.Face?, scaledSize: CGFloat) -> NSFont {
        let _face = (overrideFace ?? face)
        let supportsItalics = _face._hasItalicVariant(weight, design)

        var font = _face.fontNS(
            size: scaledSize,
            weight: weight,
            design: design,
            italic: options.contains(.italic),
            monospacedDigit: options.contains(.monospacedDigit)
        )

        if options.contains(.smallCaps) {
            font = NSFontManager.shared.convert(font, toHaveTrait: .smallCapsFontMask)
        }

        if options.contains(.italic) && !supportsItalics {
            let descriptor = font.fontDescriptor.addingAttributes([
                .traits : [NSFontDescriptor.TraitKey.slant : 0.5],
            ])

            font = NSFont(descriptor: descriptor, size: scaledSize) ?? font
        }
        return font
    }
}

extension Font.Face {

    /// Construct a base Font representation
    func fontNS(size: CGFloat, weight: Font.Weight, design: Font.Design, italic: Bool, monospacedDigit: Bool) -> NSFont {
        let nsweight = weight.ns
        let nsdesign = design.ns
        switch self {
            case .system:
                let baseDescriptor = monospacedDigit
                ? NSFont.monospacedSystemFont(ofSize: size, weight: nsweight).fontDescriptor
                : NSFont.systemFont(ofSize: size, weight: nsweight).fontDescriptor
                guard let descriptor = italic
                        ? baseDescriptor.withDesign(nsdesign)?.withSymbolicTraits(.italic)
                        : baseDescriptor.withDesign(nsdesign),
                let font = NSFont(descriptor: descriptor, size: size)
                else { return .systemFont(ofSize: size, weight: nsweight)  }
                return font

            default:
                let fontName = _names(weight, design, italic).resource
                let descriptor = NSFontDescriptor(fontAttributes: [
                    .name : fontName,
                    .traits : [italic ? NSFontDescriptor.SymbolicTraits.italic : nil]
                ])
                guard let font = NSFont(descriptor: descriptor, size: size)
                else { return .systemFont(ofSize: size, weight: nsweight) }
                return font
        }
    }
}

extension Font.Weight {
    var ns: NSFont.Weight {
        switch self {
            case .ultraLight: return .ultraLight
            case .light: return .light
            case .thin: return .thin
            case .regular: return .regular
            case .medium: return .medium
            case .semibold: return .semibold
            case .bold: return .bold
            case .heavy: return .heavy
            case .black: return .black
            default: fatalError()
        }
    }
}

extension Font.Design {
    var ns: NSFontDescriptor.SystemDesign {
        switch self {
            case .monospaced: return .monospaced
            case .rounded: return .rounded
            case .serif: return .serif
            case .default: return .default
            @unknown default: fatalError()
        }
    }
}
#endif
