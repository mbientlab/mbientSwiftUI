// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public struct MeasureWidth: View {

    @Binding var width: CGFloat

    public init(_ width: Binding<CGFloat>) {
        _width = width
    }

    public var body: some View {
        GeometryReader { geo  in
            Color.clear.hidden()
                .onAppear { width = geo.size.width }
                .onChange(of: geo.size.width) { if width != $0 { width = $0 } }
        }
    }
}

