//
//  OAuthClientID.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-24.
//

/// An ID tag for the OAuth client.
///
/// The string can only have one character. The struct will throw away any extra characters if it
/// sees more than one character.
public struct OAuthClientID: Codable, CustomStringConvertible {

    public var description: String {
        return rawValue
    }

    public let rawValue: String

    public init(validating rawValue: String) {
        self.rawValue = String(rawValue.prefix(1))
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        self.init(validating: value)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
