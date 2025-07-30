//
//  OAuthScope.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-26.
//

import Foundation

/// An structure representing the set of possible OAuth scopes as plain strings.
///
/// Each OAuth scope defines what permissions or access a client is requesting from the user.
/// This enum provides a helper for validating if a given scope string matches the expected
/// pattern, making it easier to check user input or API responses when working with OAuth.
public struct OAuthScope: Codable, CustomStringConvertible {

    public let rawValue: String

    public var description: String {
        return rawValue
    }

    /// Validates the specified raw value, then creates a new instance.
    ///
    /// The input will be valid if it includes a space-separated text of non-control ASCII characters, with
    /// the exception of a backslash (`\`) or double quote (`"`).
    ///
    /// - Parameter rawValue: The raw value to validate and use for the new instance.
    public init?(validating rawValue: String) throws {
        do {
            let pattern = #"^[\x21\x23-\x5B\x5D-\x7E]+(?: [\x21\x23-\x5B\x5D-\x7E]+)*$"#

            let regex = try NSRegularExpression(pattern: pattern)
            let range = NSRange(rawValue.startIndex..<rawValue.endIndex, in: rawValue)

            if let match = regex.firstMatch(in: rawValue, options: [], range: range) {
                self.rawValue = rawValue
            } else {
                return nil
            }
        } catch {
            // If the regex fails for whatever reason, throw an error. However, this should never happen.
            throw error
        }
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)

        guard let instance = try Self.init(validating: value) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid OAuthScope value: \(value)"
            )
        }
        self = instance
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
