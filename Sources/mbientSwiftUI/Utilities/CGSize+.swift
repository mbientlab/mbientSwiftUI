// Copyright 2022 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public extension CGSize {

    /// Distance between two points in a shared coordinate space
    /// 
    func distance(to point: CGSize) -> CGFloat {
        return sqrt(pow((point.width - width), 2) + pow((point.height - height), 2))
    }

    /// Restrict any point to within one radius of an origin, defined as CGPoint.zero
    ///
    func clamped(radius: CGFloat) -> CGSize {
        let translation = distance(to: .zero)
        guard translation > radius else { return self }
        let clamp = radius / translation
        return .init(width: width * clamp, height: height * clamp)
    }
}

extension CGSize: Comparable {

    /// Compare by relative magnitude
    ///
    public static func < (lhs: CGSize, rhs: CGSize) -> Bool {
        if lhs.equalTo(.zero) && !rhs.equalTo(.zero) { return true }
        if rhs.equalTo(.zero) && !lhs.equalTo(.zero) { return true }
        let left = pow(lhs.width, 2) + pow(lhs.height, 2)
        let right = pow(rhs.width, 2) + pow(rhs.height, 2)
        return left < right
    }
}
