// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public enum SignalLevel: Int, Identifiable, Comparable {
    case noBars
    case oneBar
    case twoBars
    case threeBars
    case fourBars
    case fiveBars

    public static let dots: [Self] = [.oneBar, .twoBars, .threeBars, .fourBars, .fiveBars]
    public static let maxBars: Int = 5
    public static let maxBarsCG: CGFloat = 5
    public static let noBarsRSSI = -100.0

    public init(rssi: Double) {
        switch rssi {
            case ...(-80): self = .noBars
            case ...(-70): self = .oneBar
            case ...(-60): self = .twoBars
            case ...(-50): self = .threeBars
            case ...(-40): self = .fourBars
            default:       self = .fiveBars
        }
    }

    public init(rssi: Int) {
        self.init(rssi: Double(rssi))
    }

    public var id: RawValue { rawValue }
    public var dots: Int { rawValue }
    public var inactiveDots: Int { Self.maxBars - rawValue }
    public static func < (lhs: SignalLevel, rhs: SignalLevel) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
