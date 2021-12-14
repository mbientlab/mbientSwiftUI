// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public extension EnvironmentValues {
    var namespace: Namespace.ID? {
        get { return self[NamespaceEVK.self] }
        set { self[NamespaceEVK.self] = newValue }
    }
}

public struct NamespaceEVK: EnvironmentKey {
    public static let defaultValue: Namespace.ID? = nil
}
