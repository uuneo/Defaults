//
//  PDDefaults.swift
//  Defaults
//
//  Created by lynn on 2025/6/1.
//

import Foundation
import Combine
import SwiftUICore

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
	
	// 支持监听多个键的变化
	public static func observe<Value: Codable>(_ key: Key<Value>, onChange: @escaping (Value) -> Void) -> AnyCancellable {
		onChange(self[key])
		return NotificationCenter.default.publisher(for: .init(key.name))
			.compactMap { $0.object as? Value }
			.sink(receiveValue: onChange)
	}
	
}




// MARK: - 属性包装器改进

@MainActor
@frozen
@propertyWrapper
public struct PDS<Value: Codable>: DynamicProperty {
	private let key: PD.Key<Value>
	@State private var value: Value
	private var cancellable: AnyCancellable?
	
	public var wrappedValue: Value {
		get { value }
		nonmutating set {
			value = newValue
			PD[key] = newValue
		}
	}
	
	public var projectedValue: Binding<Value> {
		Binding(
			get: { wrappedValue },
			set: { wrappedValue = $0 }
		)
	}
	
	public init(_ key: PD.Key<Value>) {
		self.key = key
		_value = State(initialValue: PD[key])
		
		// 修正：使用 [self] 捕获，确保在主线程更新状态
		self.cancellable = PD.observe(key) { [self] newValue in
			DispatchQueue.main.async {
				value = newValue
			}
		}
	}
}
