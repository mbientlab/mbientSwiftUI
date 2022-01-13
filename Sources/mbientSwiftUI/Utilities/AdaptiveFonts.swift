// Copyright 2022 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public extension Font.Config {

    // MARK: - Headers

    static let screenHeader           = Font.Config(.largeTitle)                .iPhone(.title2, weight: .medium)
    static let screenSubsectionTitle  = Font.Config(.title2, weight: .medium)   .iPhone(.headline)
    static let screenHeaderDetail     = screenHeader.adjustingSize(steps: -2)
    static let screenHeaderBackIcon   = Font.Config(.title2)                    .iPhone(.title3)

    static let collectionSectionTitle = Font.Config(.title2, weight: .medium, design: .rounded)
    static let subsectionTitle        = Font.Config(.title3, weight: .medium)

    // MARK: - Intents

    static let dropActionHeadline     = Font.Config(.title, weight: .semibold)
    static let primaryActionText      = Font.Config(.title)

    // MARK: - Labels
    static let body                   = Font.Config(.body)

    static let ctaMajor               = Font.Config(.title2, weight: .medium)    .iPhone(.title3)
    static let ctaMinor               = Font.Config(.title3, weight: .medium)    .iPhone(.headline)
    static let ctaAlert               = ctaMinor

    static let deviceCellTitle        = Font.Config(.title, weight: .medium)     .iPhone(.title2)
    static let deviceCellIcons        = Font.Config(.headline)

    #if os(macOS)
    static let sessionListName        = Font.Config(.title3)
    static let sessionListDate        = Font.Config(.title3)
    #elseif os(iOS)
    static let sessionListName        = Font.Config(.headline)                   .iPhone(.body)
    static let sessionListDate        = Font.Config(.headline, weight: .regular) .iPhone(.subheadline)
#endif
    static let sessionListIcon        = sessionListDate.withWeight(.medium)

    static let estimates              = Font.Config(.body)                       .iPhone(.caption)

    static let actionDeviceTitle      = Font.Config(.title2)                     .iPhone(.headline)
    static let actionStateLabel       = Font.Config(.title3, weight: .medium)    .iPhone(.subheadline)
    static let actionStateDetail      = Font.Config(.subheadline)                .iPhone(.caption)
    static let actionIcon             = Font.Config(.title, weight: .semibold)   .iPhone(.headline)

#if os(macOS)
    static let configureTileTitle     = Font.Config(.title2, weight: .medium)    .iOS(size: .title3)
    static let configureTileMenu      = Font.Config(.title3, weight: .medium)    .iOS(size: .headline)
#elseif os(iOS)
    static let configureTileTitle     = Font.Config(.title3, weight: .medium)    .iPhone(.headline)
    static let configureTileMenu      = Font.Config(.headline, weight: .medium)  .iPhone(.subheadline)
#endif
    static let configurePresentsMenu  = idiom.is_Mac ? primaryActionText : configureTileTitle

    static let hLabelSubheadline      = Font.Config(.subheadline)
    static let hLabelBody             = Font.Config(size: Font.TextStyle.callout.guidelineSize,
                                                    relativeTo: .callout,
                                                    weight: .medium,
                                                    design: .default,
                                                    options: [.monospacedDigit])

    static let scanningPrompt         = Font.Config(.headline)                    .iPhone(.caption, weight: .medium)

    // MARK: - Onboarding

#if os(macOS)
    static let onboardingLargeTitle   = Font.Config(.largeTitle, weight: .regular)
    static let onboardingHeadline     = Font.Config(.title)
    static let onboardingDescription  = Font.Config(.title2)
#elseif os(iOS)
    static let onboardingLargeTitle   = Font.Config(.title)
    static let onboardingHeadline     = Font.Config(.title2)                      .iPhone(.title3)
    static let onboardingDescription  = Font.Config(.title3)                      .iPhone(.callout)
#endif
}

// MARK: - System

public extension Font.Config {

    static let systemLargeTitle = Self.init(
        size: Font.TextStyle.largeTitle.guidelineSize,
        relativeTo: .largeTitle,
        weight: Font.TextStyle.largeTitle.guidelineWeight)

    static let systemTitle = Self.init(
        size: Font.TextStyle.title.guidelineSize,
        relativeTo: .title,
        weight: Font.TextStyle.title.guidelineWeight)

    static let systemTitle2 = Self.init(
        size: Font.TextStyle.title2.guidelineSize,
        relativeTo: .title2,
        weight: Font.TextStyle.title2.guidelineWeight)

    static let systemTitle3 = Self.init(
        size: Font.TextStyle.title3.guidelineSize,
        relativeTo: .title3,
        weight: Font.TextStyle.title3.guidelineWeight)

    static let systemHeadline = Self.init(
        size: Font.TextStyle.headline.guidelineSize,
        relativeTo: .headline,
        weight: Font.TextStyle.headline.guidelineWeight)

    static let systemCallout = Self.init(
        size: Font.TextStyle.callout.guidelineSize,
        relativeTo: .callout,
        weight: Font.TextStyle.callout.guidelineWeight)

    static let systemSubheadline = Self.init(
        size: Font.TextStyle.subheadline.guidelineSize,
        relativeTo: .subheadline,
        weight: Font.TextStyle.subheadline.guidelineWeight)

    static let systemBody = Self.init(
        size: Font.TextStyle.body.guidelineSize,
        relativeTo: .body,
        weight: Font.TextStyle.body.guidelineWeight)

    static let systemFootnote = Self.init(
        size: Font.TextStyle.footnote.guidelineSize,
        relativeTo: .footnote,
        weight: Font.TextStyle.footnote.guidelineWeight)

    static let systemCaption = Self.init(
        size: Font.TextStyle.caption.guidelineSize,
        relativeTo: .caption,
        weight: Font.TextStyle.caption.guidelineWeight)

    static let systemCaption2 = Self.init(
        size: Font.TextStyle.caption2.guidelineSize,
        relativeTo: .caption2,
        weight: Font.TextStyle.caption2.guidelineWeight)

}

fileprivate extension Font.Config {
    func iPhone(_ size: Font.TextStyle, weight: Font.Weight? = nil) -> Self {
        resize(for: .iPhone, to: size, weight: weight)
    }

    func iOS(size: Font.TextStyle, weight: Font.Weight? = nil) -> Self {
        guard idiom.is_iOS else { return self }
        return .init(face: face, size: size.guidelineSize, relativeTo: size, weight: weight ?? self.weight, design: design, options: options)
    }
}
