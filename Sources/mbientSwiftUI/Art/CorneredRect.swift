// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public struct CorneredRect: Shape {

    public init(rounding: Set<CorneredRect.Corners>, by cornerRadius: CGFloat) {
        self.rounded = rounding
        self.cornerRadius = cornerRadius
    }

    public let rounded: Set<Corners>
    public let cornerRadius: CGFloat

    public enum Corners {
        case topLeft, topRight, bottomLeft, bottomRight
    }

    public func path(in rect: CGRect) -> Path {
        let w = rect.size.width
        let h = rect.size.height
        let midX = rect.midX
        let midY = rect.midY

        func radius(_ corner: Corners) -> CGFloat {
            rounded.contains(corner) ? cornerRadius : 0
        }

        let radiusTopR      = min(min(radius(.topRight), midY), midX)
        let radiusTopL      = min(min(radius(.topLeft), midY), midX)
        let radiusBottomL   = min(min(radius(.bottomLeft), midY), midX)
        let radiusBottomR   = min(min(radius(.bottomRight), midY), midX)

        let north               = CGPoint(x: midX,              y: 0)
        let topRightStart       = CGPoint(x: w - radiusTopR,    y: 0)
        let topRightPivot       = CGPoint(x: w - radiusTopR,    y: radiusTopR)
        let bottomRightStart    = CGPoint(x: w,                 y: h - radiusBottomR)
        let bottomRightPivot    = CGPoint(x: w - radiusBottomR, y: h - radiusBottomR)
        let bottomLeftStart     = CGPoint(x: radiusBottomL,     y: h)
        let bottomLeftPivot     = CGPoint(x: radiusBottomL,     y: h - radiusBottomL)
        let topLeftStart        = CGPoint(x: 0,                 y: radiusTopL)
        let topLeftPivot        = CGPoint(x: radiusTopL,        y: radiusTopL)

        var path = Path()
        path.move(to: north)
        path.addLine(to: topRightStart)
        path.addArc(center: topRightPivot,
                    radius: radiusTopR,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)
        path.addLine(to: bottomRightStart)
        path.addArc(center: bottomRightPivot,
                    radius: radiusBottomR,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)
        path.addLine(to: bottomLeftStart)
        path.addArc(center: bottomLeftPivot,
                    radius: radiusBottomL,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180),
                    clockwise: false)
        path.addLine(to: topLeftStart)
        path.addArc(center: topLeftPivot,
                    radius: radiusTopL,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 270),
                    clockwise: false)
        path.closeSubpath()
        return path
    }
}
