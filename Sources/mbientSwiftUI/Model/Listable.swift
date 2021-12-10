// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public protocol Listable: Identifiable, Hashable {
    var label: String { get }
}
