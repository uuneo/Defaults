//
//  PDKeyProtocol.swift
//  Defaults
//
//  Created by lynn on 2025/6/1.
//

import Foundation

// 1. 定义协议（使用更清晰的命名规范，避免前导下划线）
public protocol PDKeyProtocol {
	var name: String { get set }
	init(name: String)
}

// 2. 具体实现类
public final class PDKey: PDKeyProtocol {
	public var name: String
	
	// 必须的初始化方法
	public required init(name: String) {
		self.name = name
	}
}

// 3. 类型别名（可选，若需要更短的调用名称）
public typealias PDKeys = PDKey


