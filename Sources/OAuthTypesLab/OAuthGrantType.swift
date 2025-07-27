//
//  OAuthGrantType.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-26.
//

/// An enumeration of OAuth 2.0 grant types used to obtain access tokens.
public enum OAuthGrantType: String {

    /// The "Authorization Code" grant type.
    ///
    /// Used in standard web and mobile app flows where the client redirects the user to the authorization
    /// server to obtain an authorization code, which is then exchanged for an access token. This is the
    /// most common and secure OAuth 2.0 flow.
    ///
    /// Corresponds to `authorization_code`.
    case authorizationCode = "authorization_code"

    /// The "Implicit" grant type.
    ///
    /// An optimized flow for public clients such as single-page apps or mobile apps, where tokens are
    /// returned directly from the authorization endpoint without an intermediate authorization code.
    /// This flow is less secure and has been largely superseded by the Authorization Code flow with PKCE.
    ///
    /// Corresponds to `implicit`.
    case implicit

    /// The "Refresh Token" grant type.
    ///
    /// Allows a client to exchange a valid refresh token for a new access token without further
    /// user interaction. This is typically used to maintain a user's authenticated session after the
    /// original access token expires.
    ///
    /// Corresponds to `refresh_token`.
    case refreshToken = "refresh_token"

    /// The "Resource Owner Password Credentials" grant type.
    ///
    /// Allows the client to obtain an access token by using the resource owner's username and
    /// password directly. This flow is generally discouraged except for trusted clients, as it exposes user
    /// credentials to the client.
    ///
    /// Corresponds to `password`.
    case password

    /// The "Client Credentials" grant type.
    ///
    /// Used for server-to-server authentication, where the client application authenticates as itself
    /// rather than on behalf of a user. No user interaction is required.
    ///
    /// Corresponds to `client_credentials`.
    case clientCredentials = "client_credentials"

    /// The "JWT Bearer" grant type.
    ///
    /// Allows a client to present a JSON Web Token (JWT) as an authorization grant, typically for delegated
    /// or federated authentication scenarios.
    ///
    /// Corresponds to `urn:ietf:params:oauth:grant-type:jwt-bearer`.
    case jwtBearerGrant = "urn:ietf:params:oauth:grant-type:jwt-bearer"

    /// The "SAML 2.0 Bearer" grant type.
    ///
    /// Allows a client to present a SAML 2.0 assertion as an authorization grant, enabling SSO and
    /// federated authentication.
    ///
    /// Corresponds to `urn:ietf:params:oauth:grant-type:saml2-bearer`.
    case saml2BearerGrant = "urn:ietf:params:oauth:grant-type:saml2-bearer"
}
