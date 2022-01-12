// Copyright 2022 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

/// Adds a Namespace to the environment. Auto-closure ensures encapsulated view builds only when needed.
///
public struct Namespaced<Window: View>: View {

    public init(_ window: @autoclosure @escaping () -> Window)  {
        self.window = window
    }

    private let window: () -> Window
    @Namespace private var namespace

    public var body: some View {
        window()
            .environment(\.namespace, namespace)
    }
}
