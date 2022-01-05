// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI
import MetaWear
import MetaWearSync

public struct MetaWearOutline: View {

    public init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }

    @Environment(\.isHovered) private var isHovering
    @Environment(\.isDropTarget) private var isDropping
    private var width: CGFloat
    private var height: CGFloat

    public var body: some View {
        MetaWearShape.Hoverable(width: width, height: height)
            .foregroundColor(.myHighlight)
            .scaleEffect(isDropping ? 1.3 : 0.75, anchor: .center)
            .opacity(isDropping ? 1 : 0)

            .frame(width: width, height: height)
            .animation(.spring(), value: isHovering)
            .animation(.spring(), value: isDropping)
    }
}

public struct MetaWearShadow: View {

    public init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }

    @Environment(\.colorScheme) var colorScheme
    @Environment(\.isHovered) private var isHovering
    @Environment(\.isDropTarget) private var isDropping
    private var width: CGFloat
    private var height: CGFloat

    public var body: some View {
        MetaWearShape.Hoverable(width: width, height: height)
            .foregroundColor(.black.opacity(colorScheme == .light ? 0.5 : 1))
            .blur(radius: 16)
            .scaleEffect(1.1, anchor: .center)
            .opacity(isDropping || isHovering ? 0.3 : 0)

            .frame(width: width, height: height)
            .animation(.spring(), value: isHovering)
            .animation(.spring(), value: isDropping)
    }

}

extension MetaWearShape {

    public struct Hoverable: View {

        public init(width: CGFloat, height: CGFloat) {
            self.width = width
            self.height = height
        }

        @Environment(\.isHovered) private var isHovering
        private var width: CGFloat
        private var height: CGFloat

        public var body: some View {
            MetaWearShape()
                .offset(x: width * (isHovering ? -0.18 : -0.15), y: height * -0.14)
                .aspectRatio(112/136, contentMode: .fit)
        }
    }
}
