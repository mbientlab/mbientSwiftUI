// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import Foundation

public extension EdgeInsets {
    func inverted() -> EdgeInsets {
        .init(top: -top, leading: -leading, bottom: -bottom, trailing: -trailing)
    }

    func horizontalInverted() -> EdgeInsets {
        .init(top: 0, leading: -leading, bottom: 0, trailing: -trailing)
    }
}
