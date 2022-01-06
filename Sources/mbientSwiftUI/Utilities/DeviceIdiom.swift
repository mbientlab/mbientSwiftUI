// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

#if os(macOS)
public let idiom: DeviceIdiom = .macOS
#elseif os(iOS)
public let idiom: DeviceIdiom = .init(idiom: UIDevice.current.userInterfaceIdiom)
#endif

public enum DeviceIdiom: Int, Equatable, Comparable {

    case macOS
    case catalyst
    case iPad
    case iPhone
    case tv
    case carPlay
    case unknown_iOS

    #if os(iOS)
    public init(idiom: UIUserInterfaceIdiom) {
        switch idiom {
            case .phone: self = .iPhone
            case .pad: self = .iPad
            case .tv: self = .tv
            case .carPlay: self = .carPlay
            case .mac: self = .catalyst
            default: self = .unknown_iOS
        }
    }
    #endif

    public var is_iOS: Bool { self != .macOS }

    public var is_Mac: Bool { self == .macOS }

    public static func < (lhs: DeviceIdiom, rhs: DeviceIdiom) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
