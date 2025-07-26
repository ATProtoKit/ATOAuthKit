//
//  OAuthTokenType.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-26.
//

/// Enumeration of supported OAuth token types.
///
/// This enum provides a case-insensitive input with a normalized output.
public enum OAuthTokenType: String, CaseIterable {

    /// Demonstrating Proof-of-Possession token type.
    case dpop = "DPoP"

    /// Bearer token type.
    case bearer = "Bearer"

    /// The normalized token type string.
    public var normalized: String {
        return self.rawValue
    }

    /// Attempts to create an `OAuthTokenType` from a string, normalizing case.
    ///
    /// - Parameter input: The token type string (any case).
    /// - Returns: A normalized `OAuthTokenType` if valid,  or `nil` if not.
    public static func parse(_ input: String) -> OAuthTokenType? {
        let lowercased = input.lowercased()
        switch lowercased {
            case "dpop".lowercased():
                return .dpop
            case "bearer".lowercased():
                return .bearer
            default:
                return nil
        }
    }
}
