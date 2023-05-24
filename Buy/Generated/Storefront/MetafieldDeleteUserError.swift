//
//  MetafieldDeleteUserError.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2017 Shopify Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

extension Storefront {
	/// An error that occurs during the execution of cart metafield deletion. 
	open class MetafieldDeleteUserErrorQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = MetafieldDeleteUserError

		/// The error code. 
		@discardableResult
		open func code(alias: String? = nil) -> MetafieldDeleteUserErrorQuery {
			addField(field: "code", aliasSuffix: alias)
			return self
		}

		/// The path to the input field that caused the error. 
		@discardableResult
		open func field(alias: String? = nil) -> MetafieldDeleteUserErrorQuery {
			addField(field: "field", aliasSuffix: alias)
			return self
		}

		/// The error message. 
		@discardableResult
		open func message(alias: String? = nil) -> MetafieldDeleteUserErrorQuery {
			addField(field: "message", aliasSuffix: alias)
			return self
		}
	}

	/// An error that occurs during the execution of cart metafield deletion. 
	open class MetafieldDeleteUserError: GraphQL.AbstractResponse, GraphQLObject, DisplayableError {
		public typealias Query = MetafieldDeleteUserErrorQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "code":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MetafieldDeleteUserError.self, field: fieldName, value: fieldValue)
				}
				return MetafieldDeleteErrorCode(rawValue: value) ?? .unknownValue

				case "field":
				if value is NSNull { return nil }
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: MetafieldDeleteUserError.self, field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				case "message":
				guard let value = value as? String else {
					throw SchemaViolationError(type: MetafieldDeleteUserError.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: MetafieldDeleteUserError.self, field: fieldName, value: fieldValue)
			}
		}

		/// The error code. 
		open var code: Storefront.MetafieldDeleteErrorCode? {
			return internalGetCode()
		}

		func internalGetCode(alias: String? = nil) -> Storefront.MetafieldDeleteErrorCode? {
			return field(field: "code", aliasSuffix: alias) as! Storefront.MetafieldDeleteErrorCode?
		}

		/// The path to the input field that caused the error. 
		open var field: [String]? {
			return internalGetField()
		}

		func internalGetField(alias: String? = nil) -> [String]? {
			return field(field: "field", aliasSuffix: alias) as! [String]?
		}

		/// The error message. 
		open var message: String {
			return internalGetMessage()
		}

		func internalGetMessage(alias: String? = nil) -> String {
			return field(field: "message", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
