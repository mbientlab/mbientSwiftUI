// Copyright 2022 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

public func alert(
    primaryLabel: String,
    primaryIsDestructive: Bool = false,
    secondaryLabel: String?,
    secondaryIsDestructive: Bool = false,
    title: String,
    message: String?,
    primary: @escaping () -> Void,
    secondary: @escaping () -> Void)
{
#if canImport(AppKit)
    let alert = NSAlert()
    alert.messageText = title
    if let info = message {
        alert.informativeText = info
    }

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
    alert.beginSheetModal(for: window) { userResponse in
        switch userResponse {
            case .alertFirstButtonReturn: primary()
            case .alertSecondButtonReturn: secondary()
            default: primary()
        }
    }
#else
    let alert = UIAlertController(
        title: title,
        message: message,
        preferredStyle: .alert
    )

    if let secondaryLabel = secondaryLabel {
        let secondaryButton = UIAlertAction(
            title: secondaryLabel,
            style: secondaryIsDestructive ? .destructive : .default,
            handler: { _ in secondary() }
        )
        alert.addAction(secondaryButton)
    }

    let primaryButton = UIAlertAction(
        title: primaryLabel,
        style: primaryIsDestructive ? .destructive : .default,
        handler: { _ in primary() }
    )
    alert.addAction(primaryButton)

    guard let vc = UIApplication.shared.getActiveController() else {
        secondary()
        return
    }
    vc.present(alert, animated: true, completion: nil)
#endif
}

#if os(iOS)
extension UIApplication {
    func getActiveController() -> UIViewController? {
        let scene = UIApplication.shared.connectedScenes.first(where: \.isActive) as? UIWindowScene
        let window = scene?.windows.first(where: \.isKeyWindow)
        return window?.rootViewController?.getUppermostVC() ?? window?.rootViewController
    }
}

extension UIViewController {
    func getUppermostVC() -> UIViewController? {
        if let nav = self as? UINavigationController {
            return nav.visibleViewController?.getUppermostVC()
        } else if let tab = (self as? UITabBarController)?.selectedViewController {
            return tab.getUppermostVC()
        } else if let presented = presentedViewController {
            return presented.getUppermostVC()
        } else {
            return self
        }
    }
}

extension UIScene {
    var isActive: Bool { activationState == .foregroundActive }
}
#endif
