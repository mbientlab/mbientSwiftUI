// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

/// Ensure the app's asset catalog contains these color names.
///
public extension Color {
    static let myBackground = Color("background")
    static let myGroupBackground = Color("groupBackground")
    static let myGroupBackground2 = Color("groupBackground2")
    static let myGroupBackground3 = Color("groupBackground3")
    static let myPrimary = Color("primary")
    static let mySecondary = Color("secondary")
    static let myTertiary = Color("tertiary")
    static let myFailure = Color("failure")
    static let mySuccess = Color("success")
    static let myHighlight = Color("highlight")
    static let myMint = Color("mint")
    static let myHeadline = Color("headline")
    static let myVignette = Color("vignette")
    static let myPrimaryTinted = Color("primaryTinted")

#if os(macOS)
    static let defaultSystemBackground = Color(.textBackgroundColor)
#else
    static let defaultSystemBackground = Color(.systemBackground)
#endif

}
