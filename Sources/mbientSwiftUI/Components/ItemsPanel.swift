// Copyright 2022 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI

/// Useful for onboarding, where there is an interior panel of content within the view. This implementation has a pair of MetaWears peeking from behind, with cross-platform fidget gestures. Inject [Item] to populate the panel's content into an icon-explanation style layout. Used in ``FocusFlipPanel``.
///
public struct ItemsPanel: View {

    public init(items: [ItemsPanel.Item], useSmallerSizes: Bool = false, maxWidth: CGFloat) {
        self.items = items
        self.useSmallerSizes = useSmallerSizes
        self.maxWidth = maxWidth
    }

    private var items: [Item]
    private var useSmallerSizes: Bool = false
    private var maxWidth: CGFloat

    public var body: some View {
        VStack(alignment: .center, spacing: 45) {
            ForEach(items) { item in
                ItemBox(item: item, isMinorPanel: useSmallerSizes)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(40)
        .background(PanelBG())
        .frame(maxWidth: maxWidth, alignment: .leading)
        .scrollAtAccessibilitySize()
    }
}

public extension ItemsPanel {

    struct Item: Identifiable {
        public var id: String { headline }
        public let symbol: SFSymbol
        public let headline: String
        public let description: String
        public let color: Color

        public init(symbol: SFSymbol, headline: String, description: String, color: Color) {
            self.symbol = symbol
            self.headline = headline
            self.description = description
            self.color = color
        }
    }

    struct ItemBox: View {

        public init(item: ItemsPanel.Item, isMinorPanel: Bool) {
            self.item = item
            self.isMinorPanel = isMinorPanel
        }

        private let item: Item
        private let isMinorPanel: Bool
        private let spacing: CGFloat = 15

        public var body: some View {
            VStack(alignment: .leading, spacing: spacing) {
                HStack(alignment: .center, spacing: spacing) {
                    symbol

                    Text(item.headline)
                        .adaptiveFont(.onboardingHeadline.adjustingSize(steps: isMinorPanel ? -1 : 0))
                }
                .foregroundColor(item.color)

                HStack(spacing: spacing) {
                    symbol.hidden()

                    Text(item.description)
                        .adaptiveFont(.onboardingDescription.adjustingSize(steps: isMinorPanel ? -1 : 0))
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.mySecondary)
                        .lineSpacing(5)
                }
            }
        }

        private var symbol: some View {
            item.symbol.image()
                .adaptiveFont(.onboardingHeadline.withWeight(.semibold).adjustingSize(steps: isMinorPanel ? -1 : 0))
        }
    }

    struct PanelBG: View {

        public init() { }

        @Environment(\.reverseOutColor) private var reverseOutColor
        @Environment(\.colorScheme) private var scheme
        private var isLight: Bool { scheme == .light }

        private let shape = RoundedRectangle(cornerRadius: 12)

        public var body: some View {
            if #available(macOS 12.0, iOS 15.0, *) {
                ZStack {
                    fill.opacity(isLight ? 0 : 0.8)
                    stroke
                }
                .background(isLight ? .ultraThinMaterial : .regularMaterial)
                .clipShape(shape)
                .shadow(color: .black.opacity(isLight ? 0.08 : 0.25), radius: 8, x: 2, y: 2)

            } else {
                ZStack {
                    fill
                    stroke
                }
            }
        }

        private var fill: some View {
            shape
                .foregroundColor(reverseOutColor)
                .brightness(0.03)
        }

        private var stroke: some View {
            shape
                .stroke(lineWidth: 2)
                .foregroundColor(.myTertiary.opacity(0.15))
        }
    }
}
