// Copyright 2022 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public extension Font.Config {

    // MARK: - Headers

    static let screenHeader = idiom == .iPhone
    ? Self.init(peg: .title, weight: .medium)
    : Self.init(peg: .largeTitle)
    static let screenSubsectionTitle = idiom == .iPhone
    ? Self.init(peg: .headline)
    : Self.init(peg: .title2, weight: .semibold)
    static let screenHeaderDetail = screenHeader.adjustingSize(steps: -2)
    static let screenHeaderBackIcon = Self.init(peg: .title2)

    static let collectionSectionTitle = Self.init(peg: .title2, weight: .medium, design: .rounded)
    static let subsectionTitle = Self.init(peg: .title3, weight: .medium)

    // MARK: - Intents

    static let dropActionHeadline = Self.init(peg: .title, weight: .semibold)
    static let primaryActionText = Self.init(peg: .title)

    // MARK: - Labels
    static let body = Self.init(peg: .body)

    static let ctaMajor = Self.init(peg: .title2, weight: .medium)
    static let ctaMinor = Self.init(peg: idiom == .iPhone ? .headline : .title2, weight: .medium)
    static let ctaAlert = ctaMinor

    static let deviceCellTitle = Self.init(peg: idiom == .iPhone ? .title2 : .title, weight: .medium)
    static let deviceCellIcons = Self.init(peg: .headline)

    #if os(macOS)
    static let sessionListName = Self.init(peg: .title3)
    static let sessionListDate = Self.init(peg: .title3)
    #elseif os(iOS)
    static let sessionListName = Self.init(peg: idiom == .iPhone ? .body : .headline)
    static let sessionListDate = idiom == .iPhone
    ? Self.init(peg:  .subheadline)
    : Self.init(peg: .headline, weight: .regular)
    #endif
    static let sessionListIcon = sessionListDate.withWeight(.medium)

    static let actionDeviceTitle = Self.init(peg: .title2)
    static let actionStateLabel = Self.init(peg: .title3, weight: .medium)
    static let actionStateDetail = Self.init(peg: .subheadline)
    static let actionIcon = Self.init(peg: .title, weight: .semibold)

    static let configureTileTitle = Self.init(peg: idiom.is_Mac ? .title2 : .title3, weight: .medium)
    static let configureTileMenu = Self.init(peg: idiom.is_Mac ? .title3 : .headline, weight: .medium)
    static let configurePresentsMenu = idiom.is_Mac ? primaryActionText : configureTileTitle

    static let hLabelSubheadline = Self.init(peg: .subheadline)
    static let hLabelBody = Self.init(
        size: Font.TextStyle.body.guidelineSize,
        relativeTo: .body,
        weight: .semibold,
        design: .default,
        options: [.monospacedDigit])

    static let scanningPrompt = idiom == .iPhone
    ? Self.init(peg: .caption, weight: .medium)
    : Self.init(peg: .headline)

    // MARK: - Onboarding

    static let onboardingLargeTitle = Self.init(peg: .largeTitle, weight: .medium)
    static let onboardingHeadline = Self.init(peg: .title)
    static let onboardingDescription = Self.init(peg: .title2)
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
