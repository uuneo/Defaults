import SwiftUI
#if os(macOS)
import AppKit
#else
import UIKit
#endif

@available(iOS 14.0, *)
extension Defaults.Serializable {
	public static var isNativelySupportedType: Bool { false }
}

@available(iOS 14.0, *)
extension Data: Defaults.Serializable {
	public static let isNativelySupportedType = true
}

@available(iOS 14.0, *)
extension Date: Defaults.Serializable {
	public static let isNativelySupportedType = true
}

@available(iOS 14.0, *)
extension Bool: Defaults.Serializable {
	public static let isNativelySupportedType = true
}

@available(iOS 14.0, *)
extension Int: Defaults.Serializable {
	public static let isNativelySupportedType = true
}

@available(iOS 14.0, *)
extension UInt: Defaults.Serializable {
	public static let isNativelySupportedType = true
}

@available(iOS 14.0, *)
extension Double: Defaults.Serializable {
	public static let isNativelySupportedType = true
}

@available(iOS 14.0, *)
extension Float: Defaults.Serializable {
	public static let isNativelySupportedType = true
}

@available(iOS 14.0, *)
extension String: Defaults.Serializable {
	public static let isNativelySupportedType = true
}

// swiftlint:disable:next no_cgfloat
@available(iOS 14.0, *)
extension CGFloat: Defaults.Serializable {
	public static let isNativelySupportedType = true
}

@available(iOS 14.0, *)
extension Int8: Defaults.Serializable {
	public static let isNativelySupportedType = true
}

@available(iOS 14.0, *)
extension UInt8: Defaults.Serializable {
	public static let isNativelySupportedType = true
}

@available(iOS 14.0, *)
extension Int16: Defaults.Serializable {
	public static let isNativelySupportedType = true
}

@available(iOS 14.0, *)
extension UInt16: Defaults.Serializable {
	public static let isNativelySupportedType = true
}

@available(iOS 14.0, *)
extension Int32: Defaults.Serializable {
	public static let isNativelySupportedType = true
}

@available(iOS 14.0, *)
extension UInt32: Defaults.Serializable {
	public static let isNativelySupportedType = true
}

@available(iOS 14.0, *)
extension Int64: Defaults.Serializable {
	public static let isNativelySupportedType = true
}

@available(iOS 14.0, *)
extension UInt64: Defaults.Serializable {
	public static let isNativelySupportedType = true
}

@available(iOS 14.0, *)
extension URL: Defaults.Serializable {
	public static let bridge = Defaults.URLBridge()
}

@available(iOS 14.0, *)
extension Defaults.Serializable where Self: Codable {
	public static var bridge: Defaults.TopLevelCodableBridge<Self> { Defaults.TopLevelCodableBridge() }
}

@available(iOS 14.0, *)
extension Defaults.Serializable where Self: Codable & NSSecureCoding & NSObject {
	public static var bridge: Defaults.CodableNSSecureCodingBridge<Self> { Defaults.CodableNSSecureCodingBridge() }
}

@available(iOS 14.0, *)
extension Defaults.Serializable where Self: Codable & NSSecureCoding & NSObject & Defaults.PreferNSSecureCoding {
	public static var bridge: Defaults.NSSecureCodingBridge<Self> { Defaults.NSSecureCodingBridge() }
}

@available(iOS 14.0, *)
extension Defaults.Serializable where Self: Codable & RawRepresentable {
	public static var bridge: Defaults.RawRepresentableCodableBridge<Self> { Defaults.RawRepresentableCodableBridge() }
}

@available(iOS 14.0, *)
extension Defaults.Serializable where Self: Codable & RawRepresentable & Defaults.PreferRawRepresentable {
	public static var bridge: Defaults.RawRepresentableBridge<Self> { Defaults.RawRepresentableBridge() }
}

@available(iOS 14.0, *)
extension Defaults.Serializable where Self: RawRepresentable {
	public static var bridge: Defaults.RawRepresentableBridge<Self> { Defaults.RawRepresentableBridge() }
}

@available(iOS 14.0, *)
extension Defaults.Serializable where Self: NSSecureCoding & NSObject {
	public static var bridge: Defaults.NSSecureCodingBridge<Self> { Defaults.NSSecureCodingBridge() }
}

@available(iOS 14.0, *)
extension Optional: Defaults.Serializable where Wrapped: Defaults.Serializable {
	public static var isNativelySupportedType: Bool { Wrapped.isNativelySupportedType }
	public static var bridge: Defaults.OptionalBridge<Wrapped> { Defaults.OptionalBridge() }
}

@available(iOS 14.0, *)
extension Defaults.CollectionSerializable where Element: Defaults.Serializable {
	public static var bridge: Defaults.CollectionBridge<Self> { Defaults.CollectionBridge() }
}

@available(iOS 14.0, *)
extension Defaults.SetAlgebraSerializable where Element: Defaults.Serializable & Hashable {
	public static var bridge: Defaults.SetAlgebraBridge<Self> { Defaults.SetAlgebraBridge() }
}
@available(iOS 14.0, *)
extension Set: Defaults.Serializable where Element: Defaults.Serializable {
	public static var bridge: Defaults.SetBridge<Element> { Defaults.SetBridge() }
}

@available(iOS 14.0, *)
extension Array: Defaults.Serializable where Element: Defaults.Serializable {
	public static var isNativelySupportedType: Bool { Element.isNativelySupportedType }
	public static var bridge: Defaults.ArrayBridge<Element> { Defaults.ArrayBridge() }
}

@available(iOS 14.0, *)
extension Dictionary: Defaults.Serializable where Key: LosslessStringConvertible & Hashable, Value: Defaults.Serializable {
	public static var isNativelySupportedType: Bool { (Key.self is String.Type) && Value.isNativelySupportedType }
	public static var bridge: Defaults.DictionaryBridge<Key, Value> { Defaults.DictionaryBridge() }
}

@available(iOS 14.0, *)
extension UUID: Defaults.Serializable {
	public static let bridge = Defaults.UUIDBridge()
}

@available(iOS 14.0, *)
extension Color: Defaults.Serializable {
	public static let bridge = Defaults.ColorBridge()
}


@available(macOS 14.0, iOS 17.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
extension Color.Resolved: Defaults.Serializable {}

@available(iOS 14.0, *)
extension Range: Defaults.RangeSerializable where Bound: Defaults.Serializable {
	public static var bridge: Defaults.RangeBridge<Range> { Defaults.RangeBridge() }
}

@available(iOS 14.0, *)
extension ClosedRange: Defaults.RangeSerializable where Bound: Defaults.Serializable {
	public static var bridge: Defaults.RangeBridge<ClosedRange> { Defaults.RangeBridge() }
}

#if os(macOS)
/**
`NSColor` conforms to `NSSecureCoding`, so it goes to `NSSecureCodingBridge`.
*/
extension NSColor: Defaults.Serializable {}
#else
/**
`UIColor` conforms to `NSSecureCoding`, so it goes to `NSSecureCodingBridge`.
*/
@available(iOS 14.0, *)
extension UIColor: Defaults.Serializable {}
#endif

#if os(macOS)
extension NSFontDescriptor: Defaults.Serializable {}
#else
@available(iOS 14.0, *)
extension UIFontDescriptor: Defaults.Serializable {}
#endif

extension NSUbiquitousKeyValueStore: DefaultsKeyValueStore {}
extension UserDefaults: DefaultsKeyValueStore {}

extension DefaultsLockProtocol {
	@discardableResult
	func with<R, E>(_ body: @Sendable () throws(E) -> R) throws(E) -> R where R: Sendable {
		lock()

		defer {
			unlock()
		}

		return try body()
	}
}
