import SwiftUI

public extension CGRect {
    var shortestSide: CGFloat { min(width, height) }
    var longestSide: CGFloat { max(width, height) }
}
