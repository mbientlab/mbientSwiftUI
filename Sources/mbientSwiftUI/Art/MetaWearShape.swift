//  © 2021 Ryan Ferrell. github.com/importRyan

import SwiftUI

public struct MetaWearShape: Shape {

    public init() { }

    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.68965*width, y: 1.13358*height))
        path.addCurve(to: CGPoint(x: 0.19328*width, y: 0.7619*height), control1: CGPoint(x: 0.33073*width, y: 1.13855*height), control2: CGPoint(x: 0.18509*width, y: 1.04894*height))
        path.addCurve(to: CGPoint(x: 0.69176*width, y: 0.13605*height), control1: CGPoint(x: 0.22129*width, y: 0.26425*height), control2: CGPoint(x: 0.3025*width, y: 0.13624*height))
        path.addLine(to: CGPoint(x: 0.69404*width, y: 0.13606*height))
        path.addCurve(to: CGPoint(x: 1.19024*width, y: 0.7619*height), control1: CGPoint(x: 1.08135*width, y: 0.13675*height), control2: CGPoint(x: 1.16228*width, y: 0.26524*height))
        path.addCurve(to: CGPoint(x: 0.69176*width, y: 1.13355*height), control1: CGPoint(x: 1.19844*width, y: 1.04951*height), control2: CGPoint(x: 1.05221*width, y: 1.13891*height))
        path.addLine(to: CGPoint(x: 0.68965*width, y: 1.13358*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.68951*width, y: 1.12723*height))
        path.addCurve(to: CGPoint(x: 0.30901*width, y: 1.0525*height), control1: CGPoint(x: 0.51261*width, y: 1.12968*height), control2: CGPoint(x: 0.38811*width, y: 1.10934*height))
        path.addCurve(to: CGPoint(x: 0.20112*width, y: 0.76212*height), control1: CGPoint(x: 0.23015*width, y: 0.99584*height), control2: CGPoint(x: 0.19711*width, y: 0.90313*height))
        path.addCurve(to: CGPoint(x: 0.24738*width, y: 0.40868*height), control1: CGPoint(x: 0.2095*width, y: 0.61333*height), control2: CGPoint(x: 0.22261*width, y: 0.49768*height))
        path.addCurve(to: CGPoint(x: 0.3616*width, y: 0.21771*height), control1: CGPoint(x: 0.27182*width, y: 0.32092*height), control2: CGPoint(x: 0.30746*width, y: 0.25933*height))
        path.addCurve(to: CGPoint(x: 0.69176*width, y: 0.1424*height), control1: CGPoint(x: 0.43382*width, y: 0.16219*height), control2: CGPoint(x: 0.53864*width, y: 0.14248*height))
        path.addCurve(to: CGPoint(x: 0.69402*width, y: 0.14241*height), control1: CGPoint(x: 0.69176*width, y: 0.1424*height), control2: CGPoint(x: 0.69402*width, y: 0.14241*height))
        path.addCurve(to: CGPoint(x: 1.02255*width, y: 0.21821*height), control1: CGPoint(x: 0.84636*width, y: 0.14268*height), control2: CGPoint(x: 0.95066*width, y: 0.16259*height))
        path.addCurve(to: CGPoint(x: 1.13628*width, y: 0.40922*height), control1: CGPoint(x: 1.07644*width, y: 0.2599*height), control2: CGPoint(x: 1.11193*width, y: 0.32152*height))
        path.addCurve(to: CGPoint(x: 1.1824*width, y: 0.76212*height), control1: CGPoint(x: 1.16096*width, y: 0.49814*height), control2: CGPoint(x: 1.17404*width, y: 0.61362*height))
        path.addCurve(to: CGPoint(x: 1.07405*width, y: 1.05283*height), control1: CGPoint(x: 1.18642*width, y: 0.90341*height), control2: CGPoint(x: 1.15324*width, y: 0.9962*height))
        path.addCurve(to: CGPoint(x: 0.6919*width, y: 1.1272*height), control1: CGPoint(x: 0.9946*width, y: 1.10965*height), control2: CGPoint(x: 0.86957*width, y: 1.12984*height))
        path.addCurve(to: CGPoint(x: 0.69162*width, y: 1.1272*height), control1: CGPoint(x: 0.69181*width, y: 1.1272*height), control2: CGPoint(x: 0.69171*width, y: 1.1272*height))
        path.addLine(to: CGPoint(x: 0.68951*width, y: 1.12723*height))
        path.closeSubpath()
        return path
    }
}
