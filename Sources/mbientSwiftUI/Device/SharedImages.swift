// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI
import MetaWear

public enum SharedImages: String {
    case metawearSide = "metawearSide"
    case metawearTop = "metawearTop"

    public var bundleName: String { rawValue }

    public func image() -> Image {
        Image(bundleName, bundle: .mbientShared)
    }
}

public extension MetaWear.Model {

    var image: SharedImages { .metawearTop }
}

public extension Bundle {
    static let mbientShared: Bundle = Bundle.module
}
