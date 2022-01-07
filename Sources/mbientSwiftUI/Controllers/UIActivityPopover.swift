// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

#if os(iOS)
/// Eagerly presents a `UIActivityViewController` centered on the parent view for iPhone or iPad. See [explanation](https://gist.github.com/importRyan/60cef19a017c4cc5f479d0d422c720c1).
///
public struct UIActivityPopover: UIViewControllerRepresentable {

    public init(items: [Any], activities: [UIActivity] = [], didDismiss: @escaping UIActivityViewController.CompletionWithItemsHandler) {
        self.items = items
        self.activities = activities
        self.didDismiss = didDismiss
    }

    let items: [Any]
    var activities: [UIActivity] = []
    let didDismiss: UIActivityViewController.CompletionWithItemsHandler

    public func makeUIViewController(context: Context) -> HostVC {
        HostVC(items, activities, didDismiss)
    }

    public func updateUIViewController(_ vc: HostVC, context: Context) {
        vc.prepareActivity()
    }
}

extension UIActivityPopover {

    public class HostVC : UIViewController {

        private let items: [Any]
        private let activities: [UIActivity]
        private let didDismiss: UIActivityViewController.CompletionWithItemsHandler
        private var vc: UIActivityViewController? = nil
        private var didPrepare = false
        private var didPresent = false

        init(_ items: [Any],
             _ activities: [UIActivity],
             _ didDismiss: @escaping UIActivityViewController.CompletionWithItemsHandler) {
            self.items = items
            self.activities = activities
            self.didDismiss = didDismiss
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) { fatalError() }
    }
}

extension UIActivityPopover.HostVC {

    /// Prepare popover in background (can take a second)
    ///
    func prepareActivity() {
        guard didPrepare == false else { return }
        didPrepare = true

        DispatchQueue.global().async { [self] in
            guard self.vc == nil else { return }
            vc = UIActivityViewController(activityItems: items, applicationActivities: activities)
            vc?.completionWithItemsHandler = didDismiss
            DispatchQueue.main.async { [self] in
                self.presentActivity()
            }
        }
    }

    /// Present popover in situ for iPad and iPhone.
    ///
    private func presentActivity() {
        let hasWindow = viewIfLoaded?.window != nil
        guard didPresent == false, hasWindow else { tryUntilHasWindow(); return }
        didPresent = true

        if idiom == .iPad {
            let pop = vc!.popoverPresentationController
            pop?.sourceView = self.view
            pop?.sourceRect = self.view.frame
        }

        self.present(vc!, animated: true, completion: nil)
    }

    /// SwiftUI may call `updateUIViewController` before moving this controller into a window. In this situation, presenting the `UIActivityViewController` will not work, `didDismiss` will not be called, and this export will appear to hang.
    ///
    /// This method polls for when presentation is safe.
    ///
    private func tryUntilHasWindow() {
        DispatchQueue.main.after(0.1) { [weak self] in
            self?.presentActivity()
        }
    }
}
#endif
