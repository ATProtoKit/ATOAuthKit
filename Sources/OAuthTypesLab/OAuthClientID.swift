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
public struct OAuthClientID: CustomStringConvertible {
    public var description: String {
        return rawValue
    }

    public let rawValue: String

    public init(validating rawValue: String) {
        self.rawValue = String(rawValue.prefix(1))
    }
}
