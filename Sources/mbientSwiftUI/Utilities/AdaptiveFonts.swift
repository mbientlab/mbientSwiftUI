// Copyright 2022 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public extension Font.Config {

    // MARK: - Headers

    static let screenHeader = idiom == .iPhone
    ? Font.Config(peg: .title, weight: .medium)
    : Font.Config(peg: .largeTitle)
    static let screenSubsectionTitle = idiom == .iPhone
    ? Font.Config(peg: .headline)
    : Font.Config(peg: .title2, weight: .semibold)
    static let screenHeaderDetail       = screenHeader.adjustingSize(steps: -2)
    static let screenHeaderBackIcon     = Font.Config(peg: .title2)

    static let collectionSectionTitle   = Font.Config(peg: .title2, weight: .medium, design: .rounded)
    static let subsectionTitle          = Font.Config(peg: .title3, weight: .medium)

    // MARK: - Intents

    static let dropActionHeadline       = Font.Config(peg: .title, weight: .semibold)
    static let primaryActionText        = Font.Config(peg: .title)

    // MARK: - Labels
    static let body = Font.Config(peg: .body)

    static let ctaMajor = Font.Config(peg: .title2, weight: .medium)
    static let ctaMinor = Font.Config(peg: idiom == .iPhone ? .headline : .title2, weight: .medium)
    static let ctaAlert = ctaMinor

    static let deviceCellTitle   = Font.Config(peg: idiom == .iPhone ? .title2 : .title, weight: .medium)
    static let deviceCellIcons   = Font.Config(peg: .headline)

    #if os(macOS)
    static let sessionListName   = Font.Config(peg: .title3)
    static let sessionListDate   = Font.Config(peg: .title3)
    #elseif os(iOS)
    static let sessionListName   = Font.Config(peg: idiom == .iPhone ? .body : .headline)
    static let sessionListDate   = idiom == .iPhone
    ? Font.Config(peg:  .subheadline)
    : Font.Config(peg: .headline, weight: .regular)
#endif
    static let sessionListIcon   = sessionListDate.withWeight(.medium)

    static let estimates         = Font.Config(peg: idiom == .iPhone ? .caption : .body)

    static let actionDeviceTitle = Font.Config(peg: idiom == .iPhone ? .headline : .title2)
    static let actionStateLabel  = Font.Config(peg: idiom == .iPhone ? .subheadline : .title3, weight: .medium)
    static let actionStateDetail = Font.Config(peg: idiom == .iPhone ? .caption : .subheadline)
    static let actionIcon        = Font.Config(peg: idiom == .iPhone ? .headline : .title, weight: .semibold)

#if os(macOS)
    static let configureTileTitle = Font.Config(peg: idiom.is_Mac ? .title2 : .title3, weight: .medium)
    static let configureTileMenu  = Font.Config(peg: idiom.is_Mac ? .title3 : .headline, weight: .medium)
#elseif os(iOS)
    static let configureTileTitle = Font.Config(peg: idiom == .iPhone ? .headline : .title3, weight: .medium)
    static let configureTileMenu  = Font.Config(peg: idiom == .iPhone ? .subheadline : .headline, weight: .medium)
#endif

    static let configurePresentsMenu = idiom.is_Mac ? primaryActionText : configureTileTitle

    static let hLabelSubheadline = Font.Config(peg: .subheadline)
    static let hLabelBody = Font.Config(
        size: Font.TextStyle.callout.guidelineSize,
        relativeTo: .callout,
        weight: .medium,
        design: .default,
        options: [.monospacedDigit])

    static let scanningPrompt = idiom == .iPhone
    ? Font.Config(peg: .caption, weight: .medium)
    : Font.Config(peg: .headline)

    // MARK: - Onboarding

#if os(macOS)
    static let onboardingLargeTitle = Font.Config(peg: .largeTitle, weight: .regular)
    static let onboardingHeadline = Font.Config(peg: .title)
    static let onboardingDescription = Font.Config(peg: .title2)
#elseif os(iOS)
    static let onboardingLargeTitle = Font.Config(peg: .title)
    static let onboardingHeadline = Font.Config(peg: idiom == .iPhone ? .title3 : .title2)
    static let onboardingDescription = Font.Config(peg: idiom == .iPhone ? .callout : .title3)
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
