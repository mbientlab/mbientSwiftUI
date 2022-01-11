// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI
import MetaWear
import MetaWearSync

public class RenamePopupPromptController {
    public weak var delegate: RenameDelegate? = nil
    public static var shared = RenamePopupPromptController()

    public init(delegate: RenameDelegate? = nil) {
        self.delegate = delegate
    }
}

public protocol RenameDelegate: AnyObject {
    func userDidRenameMetaWear(mac: MACAddress, newName: String)
    func userDidRenameGroup(id: UUID, newName: String)
}

public extension RenamePopupPromptController {

    /// Validates a MetaWear rename operation and presents relevant popup dialogs before delivering a valid name to the `RenameDelegate`.
    func rename(existingName: String, mac: MACAddress) {
        getNameInputModally(
            prefilledText: existingName,
            primaryLabel: "Rename",
            primaryIsDestructive: false,
            secondaryLabel: "Cancel",
            secondaryIsDestructive: false,
            title: "Rename \(existingName)",
            message: nil,
            primary: { [weak self] text in self?.userDidInput(text, existingName, mac) },
            secondary: { _ in }
        )
    }

    /// Validates a MetaWear rename operation and presents relevant popup dialogs before delivering a valid name to the `RenameDelegate`.
    func rename(existingName: String, group: UUID) {
        getNameInputModally(
            prefilledText: existingName,
            primaryLabel: "Rename",
            primaryIsDestructive: false,
            secondaryLabel: "Cancel",
            secondaryIsDestructive: false,
            title: "Rename \(existingName)",
            message: nil,
            primary: { [weak self] text in self?.delegate?.userDidRenameGroup(id: group, newName: text) },
            secondary: { _ in }
        )
    }
}

// MARK: - Internal

fileprivate extension RenamePopupPromptController {

    func userDidInput(_ text: String, _ existingName: String, _ mac: MACAddress) {
        guard MetaWear.isNameValid(text) else {
            showTryAgainDialog(for: existingName, invalidText: text, mac: mac)
            return
        }
        delegate?.userDidRenameMetaWear(mac: mac, newName: text)
    }

    func showTryAgainDialog(for existingName: String, invalidText: String, mac: MACAddress) {
        let errorMsg = "MetaWear names must be less than \(MetaWear._maxNameLength) alphanumeric characters, underscores, hyphens, or spaces. \"\(invalidText)\" is not a supported name."

        getNameInputModally(
            prefilledText: invalidText,
            primaryLabel: "Rename",
            primaryIsDestructive: false,
            secondaryLabel: "Cancel",
            secondaryIsDestructive: false,
            title: "Rename \(existingName)",
            message: errorMsg,
            primary: { [weak self] text in self?.userDidInput(text, existingName, mac) },
            secondary: { _ in }
        )
    }
}


public func getNameInputModally(
    prefilledText: String,
    primaryLabel: String,
    primaryIsDestructive: Bool = false,
    secondaryLabel: String?,
    secondaryIsDestructive: Bool = false,
    title: String,
    message: String?,
    primary: @escaping (String) -> Void,
    secondary: @escaping (String) -> Void)
{
#if canImport(AppKit)
    let alert = NSAlert()
    alert.messageText = title
    if let info = message {
        alert.informativeText = info
    }

    let input = NSTextField(frame: .init(x: 0, y: 0, width: 300, height: 26))
    input.bezelStyle = .roundedBezel
    input.controlSize = .large
    input.alignment = .center
    input.placeholderString = prefilledText
    input.stringValue = prefilledText
    input.isAutomaticTextCompletionEnabled = true
    alert.accessoryView = input


    alert.addButton(withTitle: primaryLabel)

    if primaryIsDestructive {
        alert.buttons.first?.hasDestructiveAction = true
    }

    if let secondary = secondaryLabel {
        alert.addButton(withTitle: secondary)
        if secondaryIsDestructive {
            alert.buttons[1].hasDestructiveAction = true
        }
    }

    guard let window = NSApplication.shared.keyWindow else { return }
    alert.beginSheetModal(for: window) { [weak input] userResponse in
        switch userResponse {
            case .alertFirstButtonReturn: primary(input?.stringValue ?? "")
            case .alertSecondButtonReturn: secondary(input?.stringValue ?? "")
            default: primary("Default")
        }
    }
#else
    let alert = UIAlertController(
        title: title,
        message: message,
        preferredStyle: .alert
    )

    alert.addTextField { textField in
        textField.placeholder = prefilledText
    }

    if let secondaryLabel = secondaryLabel {
        let secondaryButton = UIAlertAction(
            title: secondaryLabel,
            style: secondaryIsDestructive ? .destructive : .default,
            handler: { _ in secondary(prefilledText) }
        )
        alert.addAction(secondaryButton)
    }

    let primaryButton = UIAlertAction(
        title: primaryLabel,
        style: primaryIsDestructive ? .destructive : .default,
        handler: { [weak alert] _ in
            guard let input = alert?.textFields?.first?.text else {
                secondary(prefilledText)
                return
            }
            primary(input)
        }
    )
    alert.addAction(primaryButton)

    guard let vc = UIApplication.shared.getActiveController() else {
        secondary(prefilledText)
        return
    }
    vc.present(alert, animated: true, completion: nil)
#endif
}

