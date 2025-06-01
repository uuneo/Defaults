//
//  PDDefaults.swift
//  Defaults
//
//  Created by lynn on 2025/6/1.
//

import Foundation
import Combine

public enum PD {
	private static var cancellables = Set<AnyCancellable>()

	
	public static subscript<Value: Codable>(key: Key<Value>) -> Value {
		get { key.suite[key] }
		set {
			key.suite[key] = newValue
			NotificationCenter.default.post(name: .init(key.name), object: newValue)
		}
	}
	
	public class _AnyKey: @unchecked Sendable {
		public typealias Key = PD.Key

		public let name: String
		public let suite: UserDefaults

		fileprivate init(keyName: PDKey, suite: UserDefaults) {
			self.name = keyName.name
			self.suite = suite
		}

		/**
		Reset the item back to its default value.
		*/
		public func reset() {
			suite.removeObject(forKey: name)
		}
	}

	public typealias Keys = _AnyKey
	
	public final class Key<Value: Codable>: _AnyKey, @unchecked Sendable {
		
		@usableFromInline
		let defaultValueGetter: () -> Value
		
		public var defaultValue: Value { defaultValueGetter() }
		
		public init(
			_ keyName: PDKey,
			_ defaultValue: Value,
			suite: UserDefaults = .standard,
			iCloud: Bool = false
		) {
			defer { if iCloud { } }
			
			self.defaultValueGetter = { defaultValue }
			
			super.init(keyName: keyName, suite: suite)
		}
	}
	
	public static func publish<Value: Codable>(_ key: Key<Value>,in set: inout Set<AnyCancellable>, callBack:@escaping (Value)-> Void){
		
		callBack(Self[key])
		NotificationCenter.default.publisher(for: .init(key.name))
			.sink { _ in
				callBack(Self[key])
			}.store(in: &set)
	}
}
