//
//  OAuthRequestURI.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-26.
//

/// A structure representing an OAuth request URI.
public struct OAuthRequestURI: Codable, CustomStringConvertible {

    public let rawValue: String

    public var description: String {
        return rawValue
    }

    /// Creates a new instance with the specified raw value..
    ///
    /// - Parameter rawValue: The raw value to validate and use for the new instance.
    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.rawValue = try container.decode(String.self)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
