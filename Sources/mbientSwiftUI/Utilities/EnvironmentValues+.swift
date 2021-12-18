// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

@_exported import SwiftUI
import CoreBluetooth
import MetaWear
import MetaWearSync

public extension EnvironmentValues {

    /// Parent animation unique ID space
    var namespace: Namespace.ID? {
        get { return self[NamespaceEVK.self] }
        set { self[NamespaceEVK.self] = newValue }
    }

    /// Is the parent hierarchy a current drop target
    var dropOutcome: DraggableMetaWear.DropOutcome {
        get { return self[DropOutcomeEVK.self] }
        set { self[DropOutcomeEVK.self] = newValue }
    }

    /// Is the parent hierarchy a current drop target
    var isDropTarget: Bool {
        get { return self[IsDropTargetEVK.self] }
        set { self[IsDropTargetEVK.self] = newValue }
    }

    /// Is the parent hierarchy hovered
    var isHovered: Bool {
        get { return self[IsHoveredEVK.self] }
        set { self[IsHoveredEVK.self] = newValue }
    }

    /// Should this view be in a "dimmed" or "full brightness" state
    var isDimmed: Bool {
        get { return self[IsDimmedEVK.self] }
        set { self[IsDimmedEVK.self] = newValue }
    }

    /// Peripheral's current connection state
    var connectionState: CBPeripheralState {
        get { return self[ConnectionStateEVK.self] }
        set { self[ConnectionStateEVK.self] = newValue }
    }

    /// RSSI category
    var signalLevel: SignalLevel {
        get { return self[SignalLevelEVK.self] }
        set { self[SignalLevelEVK.self] = newValue }
    }

    /// Marketing model
    var metaWearModel: MetaWear.Model {
        get { return self[ModelEVK.self] }
        set { self[ModelEVK.self] = newValue }
    }

    /// NSItemProvider
    var dragProvider: () -> NSItemProvider {
        get { return self[DragProviderEVK.self] }
        set { self[DragProviderEVK.self] = newValue }
    }
}

// MARK: - Keys

private struct NamespaceEVK: EnvironmentKey {
    public static let defaultValue: Namespace.ID? = nil
}

private struct IsHoveredEVK: EnvironmentKey {
    public static let defaultValue: Bool = false
}

private struct IsDropTargetEVK: EnvironmentKey {
    public static let defaultValue: Bool = false
}

private struct IsDimmedEVK: EnvironmentKey {
    public static let defaultValue: Bool = false
}

private struct ConnectionStateEVK: EnvironmentKey {
    public static let defaultValue: CBPeripheralState = .disconnected
}

private struct SignalLevelEVK: EnvironmentKey {
    public static let defaultValue: SignalLevel = .noBars
}

private struct ModelEVK: EnvironmentKey {
    public static let defaultValue: MetaWear.Model = .unknown
}

private struct DragProviderEVK: EnvironmentKey {
    public static let defaultValue: () -> NSItemProvider = { NSItemProvider() }
}

private struct DropOutcomeEVK: EnvironmentKey {
    public static let defaultValue: DraggableMetaWear.DropOutcome = .noDrop
}

