// Copyright 2022 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

// MARK: - API: View

public extension View {
    /// Applies a system-scaled custom font that adapts to a user's preference (e.g., for dyslexia or additional font scaling)
    func adaptiveFont(_ config: Font.Config) -> some View {
        self.modifier(AdaptiveFontModifier(config))
    }
}

public extension Font {
    /// Creates a non-system scaled custom font that adapts to a user's preference (e.g., for dyslexia or additional font scaling)
    func adaptiveFace(notScaled config: Font.Config) -> Font {
        config.getFont(overrideFace: nil, scaledSize: config.size)
    }
}

public extension EnvironmentValues {
    /// User-selected font face that will override any `.adaptive` font styles
    var fontFace: Font.Face? {
        get { return self[FontFaceEVK.self] }
        set { self[FontFaceEVK.self] = newValue }
    }

    /// User-selected font scaling beyond system scaling
    var userFontScaling: CGFloat {
        get { return self[UserFontScalingEVK.self] }
        set { self[UserFontScalingEVK.self] = newValue }
    }

    /// Offset applied to a hierarchy to compensate for a user-selected font face
    var baselineOffset: CGFloat {
        get { return self[BaselineOffsetEVK.self] }
        set { self[BaselineOffsetEVK.self] = newValue }
    }
}

// MARK: - API: Configuration Builder

public extension Font {

    /// Constructs a scaling Font instance
    struct Config {
        public var face: Face
        public var size: CGFloat
        public var anchor: TextStyle
        public var weight: Weight
        public var design: Design
        public var options: Set<Options>
    }
}

public extension Font.Config {

    /// Construct a configured Font instance
    func getFont(overrideFace: Font.Face?, scaledSize: CGFloat) -> Font {
        let _face = (overrideFace ?? face)
        let hasItalics = _face._hasItalicVariant(weight, design)

        var font = _face.font(
            size: scaledSize,
            weight: weight,
            design: design,
            italic: options.contains(.italic)
        )
        if options.contains(.monospacedDigit) { font = font.monospacedDigit() }
        if options.contains(.smallCapsLowercase) { font = font.lowercaseSmallCaps() }
        else if options.contains(.smallCapsUppercase) { font = font.uppercaseSmallCaps() }
        else if options.contains(.smallCaps) { font = font.smallCaps() }
        if options.contains(.italic) && !hasItalics { font = font.italic() }
        return font
    }

    /// Offset to render a custom font face alongside the system font
    func getBaselineOffset(overrideFace: Font.Face?, scaledSize: CGFloat) -> CGFloat {
        (overrideFace ?? face).baselineOffset(pointSize: scaledSize)
    }

    /// Construct a custom user-adaptive font style
    init(face: Font.Face = .system,
         size: CGFloat,
         relativeTo: Font.TextStyle,
         weight: Font.Weight,
         design: Font.Design,
         options: Set<Font.Options>
    ) {
        self.face = face
        self.size = size
        self.anchor = relativeTo
        self.weight = weight
        self.design = design
        self.options = options
    }

}

// MARK: - API: Font Faces

public extension Font {

    /// This app's font faces
    enum Face: String, Hashable, CaseIterable, Identifiable {
        case system
        case chalkboard
        case openDyslexic
    }
}

public extension Font.Face {

    /// Display name for a font configuration
    func name(_ weight: Font.Weight, _ design: Font.Design, italic: Bool) -> String {
        _names(weight, design, italic).display
    }

    /// Construct a base Font representation
    func font(size: CGFloat, weight: Font.Weight, design: Font.Design, italic: Bool) -> Font {
        switch self {
            case .system: return .system(size: size, weight: weight, design: design)
            default:      return .custom(_names(weight, design, italic).resource, size: size)
        }
    }

    /// Offset to render a custom font face alongside the system font
    func baselineOffset(pointSize: CGFloat) -> CGFloat {
        switch self {
            case .system: return 0
            case .chalkboard: return 0
            case .openDyslexic: return 4
        }
    }

    /// Does this font have italic faces?
    func _hasItalicVariant(_ weight: Font.Weight, _ design: Font.Design) -> Bool {
        switch self {
            case .system: return true
            default: return false
        }
    }

    func _names(_ weight: Font.Weight, _ design: Font.Design, _ italic: Bool) -> (resource: String, display: String) {
        switch self {
            case .system: return ("", "System default")

            case .chalkboard:
                if design == .monospaced { return ("ChalkboardSE-Regular", "Chalkboard") }
                switch weight {
                    case (.medium)...: return ("ChalkboardSE-Bold", "Chalkboard Bold")
                    case ...(.regular): return ("ChalkboardSE-Regular", "Chalkboard")
                    default: return ("", "")
                }

            case .openDyslexic:
                if design == .monospaced { return ("OpenDyslexicMono-Regular", "OpenDyslexic 3 Monospaced") }
                switch weight {
                    case (.medium)...: return ("OpenDyslexicThree-Bold", "OpenDyslexic 3 Bold")
                    case ...(.regular): return ("OpenDyslexicMono-Regular", "OpenDyslexic 3")
                    default: return ("", "")
                }
        }
    }

    var id: RawValue { rawValue }
}

// MARK: - API: Options

public extension Font {

    enum Options {
        case monospacedDigit
        case smallCapsUppercase
        case smallCapsLowercase
        case smallCaps
        case italic
    }
}

// MARK: - Implementation: ViewModifier

fileprivate struct AdaptiveFontModifier: ViewModifier {

    init(_ config: Font.Config) {
        self.config = config
        _scaledSize = .init(wrappedValue: config.size, relativeTo: config.anchor)
    }

    @ScaledMetric private var scaledSize: CGFloat
    @Environment(\.fontFace) private var face
    @Environment(\.userFontScaling) private var userScaling
    private let config: Font.Config

    func body(content: Content) -> some View {
        let size = scaledSize + userScaling
        let offset = config.getBaselineOffset(overrideFace: face, scaledSize: size)
        return content
            .alignmentGuide(.firstTextBaseline) { $0[.firstTextBaseline] + offset }
            .environment(\.baselineOffset, offset)
            .font(config.getFont(overrideFace: face, scaledSize: size))
    }
}

// MARK: - Support: Private EnviromentKeys

private extension EnvironmentValues {

    struct FontFaceEVK: EnvironmentKey {
        static let defaultValue: Font.Face? = nil
    }

    struct UserFontScalingEVK: EnvironmentKey {
        static let defaultValue: CGFloat = 0
    }

    struct BaselineOffsetEVK: EnvironmentKey {
        static let defaultValue: CGFloat = 0
    }
}

// MARK: - Support: Comparable+

extension Font.Weight: Comparable {
    public static func < (lhs: Font.Weight, rhs: Font.Weight) -> Bool {
        lhs.css < rhs.css
    }

    public var css: Int {
        switch self {
            case .ultraLight: return 100
            case .light: return 200
            case .thin: return 300
            case .regular: return 400
            case .medium: return 500
            case .semibold: return 600
            case .bold: return 700
            case .heavy: return 800
            case .black: return 900
            default:  return 400
        }
    }
}

extension Font.TextStyle: Comparable {

    public static func < (lhs: Font.TextStyle, rhs: Font.TextStyle) -> Bool {
        lhs.guidelineSize < rhs.guidelineSize
    }

#if os(iOS)
    /// Human Interface Guidelines
    public var guidelineSize: CGFloat {
        switch self {
            case .largeTitle: return 34
            case .title: return 28
            case .title2: return 22
            case .title3: return 20
            case .headline: return 17
            case .callout: return 16
            case .subheadline: return 15
            case .body: return 17
            case .footnote: return 13
            case .caption: return 12
            case .caption2: return 11
            @unknown default: fatalError()
        }
    }
#elseif os(macOS)
    /// Human Interface Guidelines
    public var guidelineSize: CGFloat {
        switch self {
            case .largeTitle: return 32
            case .title: return 22
            case .title2: return 17
            case .title3: return 15
            case .headline: return 13
            case .callout: return 12
            case .subheadline: return 11
            case .body: return 13
            case .footnote: return 10
            case .caption: return 10
            case .caption2: return 10
            @unknown default: fatalError()
        }
    }
#endif

#if os(iOS)
    public var guidelineWeight: CGFloat {
        switch self {
            case .headline: return .semibold
            default: return .regular
        }
    }
#elseif os(macOS)
    public var guidelineWeight: Font.Weight {
        switch self {
            case .headline: return .bold
            case .caption2: return .medium
            default: return .regular
        }
    }
#endif
}
