// Copyright 2022 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public extension CGFloat {

    init(macOS: CGFloat, iPad: CGFloat, iOS: CGFloat) {
#if os(macOS)
        self = macOS
#else
        if idiom == .iPad { self = iPad } else { self = iOS }
#endif
    }

    init(macOS: CGFloat, iOS: CGFloat) {
#if os(macOS)
        self = macOS
#else
        self = iOS
#endif
    }

    init(iPad: CGFloat, _ other: CGFloat) {
#if os(macOS)
        self = other
#else
        if idiom == .iPad { self = iPad } else { self = other }
#endif
    }

    init(iPhone: CGFloat, _ other: CGFloat) {
#if os(macOS)
        self = other
#else
        if idiom == .iPhone { self = iPhone } else { self = other }
#endif
    }
}
