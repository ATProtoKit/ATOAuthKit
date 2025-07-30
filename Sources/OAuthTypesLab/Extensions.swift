//
//  Extensions.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-30.
//

import Jot

extension String {

    /// Returns the character at the specified zero-based index if it exists.
    ///
    /// - Parameter index: The index number to search for.
    /// - Returns: The `Character` object containing the indexed character from the string (if valid), or
    /// `nil` (if not).
    public func character(at index: Int) -> Character? {
        guard index >= 0 && index < self.count else { return nil }
        let stringIndex = self.index(self.startIndex, offsetBy: index)

        return self[stringIndex]
    }
}

/// A container representing an array of  `JSONWebKey` objects.
///
/// - Note: This is being used to help align the libraries with the official TypeScript packages.
public struct JSONWebKeyContainer: Codable, Hashable, Sendable {

    /// An array of keys.
    public let keys: [JSONWebKey]

    public init(keys: [JSONWebKey]) {
        self.keys = keys
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode([JSONWebKey].self)
        self.init(keys: value)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(keys)
    }
}
