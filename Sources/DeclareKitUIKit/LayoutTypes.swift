import UIKit

/// A set of edges used to specify which sides of a view to constrain.
public struct LayoutEdge: OptionSet, Sendable {
    public let rawValue: UInt8

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }

    public static let top      = LayoutEdge(rawValue: 1 << 0)
    public static let leading  = LayoutEdge(rawValue: 1 << 1)
    public static let bottom   = LayoutEdge(rawValue: 1 << 2)
    public static let trailing = LayoutEdge(rawValue: 1 << 3)

    public static let horizontal: LayoutEdge = [.leading, .trailing]
    public static let vertical:   LayoutEdge = [.top, .bottom]
    public static let all:        LayoutEdge = [.top, .leading, .bottom, .trailing]
}

/// References a UIView layout guide by name.
public enum LayoutGuideReference: Sendable {
    case safeAreaLayoutGuide
    case layoutMarginsGuide
    case readableContentGuide
}

/// References a dimension anchor on a view, used for aspect ratio constraints.
public enum DimensionAnchor: Sendable {
    case widthAnchor
    case heightAnchor
}
