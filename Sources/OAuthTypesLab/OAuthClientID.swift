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
public struct OAuthClientID: ExpressibleByStringLiteral {

    /// The private container for the ID.
    private var privateStringValue: String

    /// The value of the ID.
    public var stringValue: String {
        get {
            return privateStringValue
        } set {
            privateStringValue = String(newValue.prefix(1))
        }
    }

    public init(stringLiteral value: String) {
        self.privateStringValue = value
    }
}
