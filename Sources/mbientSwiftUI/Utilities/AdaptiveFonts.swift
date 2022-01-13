// Copyright 2022 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public extension Font.Config {

    // MARK: - Headers

    static let screenHeader           = Font.Config(.largeTitle)                  .iPhone(.title3, weight: .medium)
    static let screenHeaderBackIcon   = Font.Config(.title2)                      .iPhone(.subheadline)
    static let screenSubsectionTitle  = Font.Config(.title2, weight: .medium)     .iPhone(.headline)
    static let screenHeaderDetail     = screenHeader.adjustingSize(steps: idiom.is_iPhone ? -3 : -2)

    static let collectionSectionTitle = Font.Config(.title2, weight: .medium, design: .rounded)
    static let subsectionTitle        = Font.Config(.title3, weight: .medium)
    static let scanningPrompt         = Font.Config(.headline)                    .iPhone(.caption, weight: .medium)

    static let dropActionHeadline     = Font.Config(.title, weight: .semibold)

    // MARK: - Labels

    static let deviceCellTitle        = Font.Config(.title, weight: .medium)     .iPhone(.title2)
    static let deviceCellIcons        = Font.Config(.headline)

    static let sessionListName        = Font.Config.mac(.title3, iPad: .headline, iPhone:.body)
    static let sessionListDate        = Font.Config.mac(.title3, iPad: .headline, iPhone:.subheadline)
    static let sessionListIcon        = sessionListDate.withWeight(.medium)

    static let configureSessionTitle  = Font.Config.mac(.title,  iPad: .title2,   iPhone:.title3)
    static let configureTileTitle     = Font.Config.mac(.title2, iPad: .title3,   iPhone:.headline,    weight: .medium)
    static let configureTileMenu      = Font.Config.mac(.title3, iPad: .headline, iPhone:.headline,    weight: .medium)
    static let estimates              = Font.Config(.body)                       .iPhone(.caption)

    static let actionDeviceTitle      = Font.Config(.title2)                     .iPhone(.headline)
    static let actionStateLabel       = Font.Config(.title3, weight: .medium)    .iPhone(.subheadline)
    static let actionStateDetail      = Font.Config(.subheadline)                .iPhone(.caption)
    static let actionIcon             = Font.Config(.title, weight: .semibold)   .iPhone(.headline)

    static let body                   = Font.Config(.body)
    static let ctaMajor               = Font.Config(.title2, weight: .medium)    .iPhone(.title3)
    static let ctaMinor               = Font.Config(.title3, weight: .medium)    .iPhone(.headline)
    static let ctaAlert               = ctaMinor
    static let primaryActionText      = Font.Config(.title)

    static let hLabelSubheadline      = Font.Config(.subheadline)
    static let hLabelBody             = Font.Config(size: Font.TextStyle.callout.guidelineSize,
                                                    relativeTo: .callout,
                                                    weight: .medium,
                                                    design: .default,
                                                    options: [.monospacedDigit])

    // MARK: - Onboarding

    static let onboardingLargeTitle   = Font.Config.mac(.largeTitle, iPad: .title,  iPhone: .title)
    static let onboardingHeadline     = Font.Config.mac(.title,      iPad: .title2, iPhone: .headline).iPhone(weight: .medium)
    static let onboardingDescription  = Font.Config.mac(.title2,     iPad: .title3, iPhone: .callout)
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

    static func mac(_ size: Font.TextStyle, iPad: Font.TextStyle, iPhone: Font.TextStyle, weight: Font.Weight = .regular) -> Self {
        #if os(macOS)
        Font.Config(size, weight: weight, design: .default, options: [])
        #else
        Font.Config(idiom == .iPhone ? iPhone : iPad, weight: weight, design: .default, options: [])
        #endif
    }

    func iPhone(_ size: Font.TextStyle, weight: Font.Weight? = nil) -> Self {
        resize(for: .iPhone, to: size, weight: weight)
    }

    func iPad(_ size: Font.TextStyle, weight: Font.Weight? = nil) -> Self {
        resize(for: .iPad, to: size, weight: weight)
    }

    func iOS(size: Font.TextStyle, weight: Font.Weight? = nil) -> Self {
        guard idiom.is_iOS else { return self }
        return .init(face: face, size: size.guidelineSize, relativeTo: size, weight: weight ?? self.weight, design: design, options: options)
    }

    func iPhone(weight: Font.Weight) -> Self {
        #if os(iOS)
        idiom.is_iPhone ? self.withWeight(weight) : self
        #else
        return self
        #endif
    }
}
