//
//  OAuthResponseType.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-26.
//

/// An enumeration representing the allowed OAuth and OpenID Connect response types.
///
/// - SeeAlso:\
/// \* OAuth2: https://datatracker.ietf.org/doc/html/draft-ietf-oauth-v2-1-10#section-4.1.1\
/// \* OpenID Connect: https://openid.net/specs/oauth-v2-multiple-response-types-1_0.html
public enum OAuthResponseType: String, Codable {

    // OAuth2 response types
    /// An authorization code to be exchanged for tokens.
    ///
    /// - Note: OAuth 2.0 Authorization Code Grant\
    /// Value: `code`
    case authorizationCodeGrant = "code"

    /// An access token directly from the authorization endpoint.
    ///
    /// - Note: OAuth 2.0 Implicit Grant\
    /// Corresponds to: `token`
    case implicitGrant = "token"

    // OpenID Connect response types
    /// No token or code is issued.
    ///
    /// Used primarily for requests that only perform authentication.
    ///
    /// - Note: OpenID Connect\
    /// Corresponds to: `none`
    case none = "none"

    /// Returns an authorization code, ID token, and access token in a single response.
    ///
    /// - Note: OpenID Connect Hybrid Flow\
    /// Corresponds to: `code id_token token`
    case codeIDTokenToken = "code id_token token"


    /// Returns an authorization code and an ID token.
    ///
    /// - Note: OpenID Connect Hybrid Flow\
    /// Value: `code id_token`
    case codeIDToken = "code id_token"

    /// Returns an authorization code and an access token.
    ///
    /// - Note: OpenID Connect Hybrid Flow\
    /// Corresponds to: `code token`
    case codeToken = "code token"

    /// Returns an ID token and an access token.
    ///
    /// - Note: OpenID Connect Implicit or Hybrid Flow\
    /// Corresponds to: `id_token token`
    case idTokenToken = "id_token token"

    /// Returns only an ID token (no access token or code).
    ///
    /// - Note: OpenID Connect Implicit Flow\
    /// Corresponds to: `id_token`
    case idToken = "id_token"
}
