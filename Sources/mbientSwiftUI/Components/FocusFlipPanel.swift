// Copyright 2022 MbientLab Inc. All rights reserved. See LICENSE.MD.

import Combine
import SwiftUI

/// Useful for onboarding scene where you can swipe content and use a flip-card effect between and A and B hierarchy.
///
public struct FocusFlipPanel<Focus:FlipPanelFocus, Up: View, Down: View, CTA: View>: View {

    public init(vm: FocusPanelVM<Focus>,
                centerColumnNominalWidth: CGFloat = 450,
                macOSHostWindowPrefix: String? = nil,
                @ViewBuilder up: @escaping (_ maxWidth: CGFloat) -> Up,
                @ViewBuilder down: @escaping (_ maxWidth: CGFloat) -> Down,
                @ViewBuilder cta: @escaping () -> CTA
    ) {
        self.vm = vm
        self.nominalWidth = centerColumnNominalWidth
        self.up = up
        self.down = down
        self.cta = cta
        self.hostWindowPrefix = macOSHostWindowPrefix
    }

    @ObservedObject private var vm: FocusPanelVM<Focus>

    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.sizeCategory) private var typeSize
    private var isAccessibilitySize: Bool { typeSize.isAccessibilityCategory }
    private var centerColumnWidth: CGFloat { isAccessibilitySize ? .infinity : nominalWidth }
    private let nominalWidth: CGFloat

    private var up: (CGFloat) -> Up
    private var down: (CGFloat) -> Down
    private var cta: () -> CTA
    private let hostWindowPrefix: String?

    public var body: some View {
        VStack(alignment: .center, spacing: isAccessibilitySize || idiom == .iPhone ? 35 : 45) {

            Text(vm.title)
                .adaptiveFont(.onboardingLargeTitle)
                .padding(.bottom, isAccessibilitySize ? 20 : 0)
                .padding(.bottom, idiom == .iPhone ? 10 : 0)

            if idiom == .iPhone { flip }
            else { flip.modifier(PeekingMetaWearBG()) }

            cta()
                .frame(maxWidth: centerColumnWidth, alignment: .center)
        }
        .padding(.bottom, idiom == .iPhone ? 20 : 45)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .backgroundToEdges(.defaultSystemBackground)
        .onReceive(vm.dismissPanel, perform: dismiss)
    }

    private var flip: some View {
        FlipView(
            up: up(centerColumnWidth),
            down: down(centerColumnWidth),
            showFaceUp: vm.showPrimaryPane
        )
    }

    private func dismiss() {
#if os(iOS)
        presentationMode.wrappedValue.dismiss()
#elseif os(macOS)
        guard let hostWindowPrefix = hostWindowPrefix,
              let target = NSApp.windows
                .filter ({ $0.identifier?.rawValue.hasPrefix(hostWindowPrefix) == true })
                .sorted(by: { lhs, rhs in lhs.isKeyWindow })
                .first
        else { presentationMode.wrappedValue.dismiss(); return }

        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.25
            target.animator().alphaValue = 0
        }) { target.close() }
#endif
    }
}

// MARK: - Controller & Model

/// Table of contents, so to speak
///
public protocol FlipPanelFocus: Identifiable {
    func next() -> Self
    func previous() -> Self
}

/// Controller for panel's title, current content, A/B flip, and dismissal
///
open class FocusPanelVM<Focus:FlipPanelFocus>: ObservableObject {

    @Published public private(set) var showPrimaryPane = true
    @Published public private(set) var title: String
    @Published public private(set) var focus: Focus
    public let dismissPanel = PassthroughSubject<Void,Never>()

    private let titleMethod: (Focus) -> String

    public init(initialFocus: Focus, title: @escaping (Focus) -> String) {
        self.focus = initialFocus
        self.title = title(initialFocus)
        self.titleMethod = title
    }

    public func setFocus(_ new: Focus) {
        focus = new
        title = titleMethod(new)
    }

    public func next() {
        setFocus(focus.next())
    }

    public func previous() {
        setFocus(focus.previous())
    }

    public func setShowPrimaryPane(_ newValue: Bool) {
        showPrimaryPane = newValue
    }
}
