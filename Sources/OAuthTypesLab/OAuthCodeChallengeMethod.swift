//
//  OAuthCodeChallengeMethod.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-28.
//

/// An enumeration representing the code challenge methods supported in OAuth 2.0 and
/// OpenID Connect flows.
public enum OAuthCodeChallengeMethod: String {

    /// The `S256` method.
    ///
    /// This is the recommended and most secure method. It ensures that the original code verifier is never
    /// transmitted over the network.
    case s256 = "S256"

    /// The `plain` method.
    ///
    /// This method is not recommended unless the client is unable to support the `S256` transformation.
    /// Use only in cases where both client and server explicitly support and allow it.
    case plain
}
