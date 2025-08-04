//
//  OAuthAccessToken.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-28.
//

/// A structure representing an OAuth access token.
public struct OAuthAccessToken: Codable, CustomStringConvertible {

    private let rawValue: String

    public var description: String {
        return rawValue
    }

    public init?(validating rawValue: String) {
        self.rawValue = rawValue
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)

        guard let instance = Self.init(validating: value) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid OAuthAccessToken value: \(value)"
            )
        }
        self = instance
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
