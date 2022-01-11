// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public enum SFSymbol: String {
    case identity = "info.circle"
    case battery = "battery.25"
    case signal = "antenna.radiowaves.left.and.right"
    case firmware = "internaldrive"
    case reset = "restart.circle"
    case mechanicalSwitch = "togglepower"
    case led = "light.max"
    case temperature = "thermometer"
    case accelerometer = "hand.draw"

    case sensorFusion = "infinity"
    case gyroscope = "gyroscope"
    case magnetometer = "location.north.line"
    case gpio = "selection.pin.in.out"
    case haptic = "arrow.up.and.down.and.arrow.left.and.right"
    case ibeacon = "mappin.and.ellipse"
    case barometer = "barometer"
    case ambientLight = "rays"
    case hygrometer = "drop"
    case i2c = "fiberchannel"

    case steps = "figure.walk"
    case refresh = "arrow.clockwise"
    case solidCircle = "circle.fill"
    case flash = "bolt.circle.fill"
    case orientation = "move.3d"
    case send = "square.and.arrow.up"
    case download = "arrow.down.circle"

    case connected = "bolt.horizontal.fill"
    case disconnected = "bolt.horizontal"
    case useMetaboot = "cross.case"
    case search = "magnifyingglass"
    case shortcutMenu = "list.dash"
    case icloud = "icloud"
    case icloudSaved = "checkmark.icloud"

    case settings = "gearshape.fill"
    case delete = "trash"
    case logs = "doc.plaintext"
    case dc = "directcurrent"

    case start = "arrow.backward.to.line"
    case end = "arrow.forward.to.line"

    case stream = "dot.radiowaves.right"
    case log = "externaldrive"

    case back = "arrow.backward"
    case moreMenu = "ellipsis.circle.fill"
    case group = "circle.hexagonpath"
    case flashlight = "flashlight.on.fill"
    case add = "plus"

    case checkFilled = "checkmark.circle.fill"
    case error = "exclamationmark.triangle.fill"

    case swift = "swift"
    case nextChevron = "chevron.right"
    case prevChevron = "chevron.left"
}

public extension SFSymbol {

    func image() -> Image {
        Image(systemName: self.rawValue)
    }

    var accessibilityDescription: String {
        switch self {
            case .accelerometer: return "Accelerometer"
            case .identity: return "Info"
            case .battery: return "Battery"
            case .signal: return "Signal Waves"
            case .firmware: return "Firmware"
            case .reset: return "Reset"
            case .mechanicalSwitch: return "Mechanical Switch"
            case .led: return "LED"
            case .temperature: return "Temperature"
            case .steps: return "Walking Steps"
            case .sensorFusion: return "Sensor Fusion"
            case .gyroscope: return "Gyroscope"
            case .magnetometer: return "Magnetometer"
            case .gpio: return "General Purpose In-Out"
            case .haptic: return "Haptic"
            case .ibeacon: return "iBeacon"
            case .barometer: return "Barometer"
            case .ambientLight: return "Ambient Light"
            case .hygrometer: return "Hygrometer Water Vapor"
            case .i2c: return "I2C"

            case .refresh: return "Refresh Arrow"
            case .solidCircle: return "Circle"
            case .flash: return "Lightning Flash"
            case .orientation: return "3D Orientation"
            case .send: return "Export"
            case .download: return "Download"

            case .connected: return "Device Connected Bolt"
            case .disconnected: return "Device Connected Empty Bolt"
            case .useMetaboot: return "MetaBoot Rescue"
            case .search: return "Search"
            case .shortcutMenu: return "Table of Contents"
            case .icloud: return "iCloud"
            case .icloudSaved: return "Saved to iCloud"

            case .settings: return "Options"
            case .delete: return "Delete"
            case .logs: return "Logs"
            case .dc: return "GPIO Edge"
            case .start: return "Go to Start"
            case .end: return "Go to End"

            case .stream: return "Stream"
            case .log: return "Log"

            case .back: return "Back"
            case .moreMenu: return "Menu"
            case .group: return "Group"
            case .flashlight: return "Search"
            case .add: return "New"

            case .checkFilled: return "Done"
            case .error: return "Error"
            case .swift: return "Swift"
            case .nextChevron: return "More"
            case .prevChevron: return "Back"
        }
    }
}
