// Copyright 2022 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public extension View {
    func handleOnlyEvents(_ events: ExternalEvents...) -> some View {
        handlesExternalEvents(preferring: .events(events),
                              allowing: .events(events))
    }
}

public extension WindowGroup {
    func handleOnlyEvents(_ events: ExternalEvents...) -> some Scene {
        handlesExternalEvents(matching: .events(events))
    }
}

public extension Set where Element == String {
    static func events(_ events: ExternalEvents...) -> Set<String> {
        Set(events.map(\.tag))
    }

    static func events(_ events: [ExternalEvents]) -> Set<String> {
        Set(events.map(\.tag))
    }
}

public protocol ExternalEvents {
    var url: URL { get }
    var tag: String { get }
}
