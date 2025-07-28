//
//  OAuthEndpointAuthMethod.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-28.
//

/// An enumeration. representing the supported client authentication methods for OAuth 2.0 and
/// OpenID Connect token and authorization endpoints.
public enum OAuthEndpointAuthMethod: String {

    /// Client authentication using HTTP Basic Authentication with the client ID and client secret.
    ///
    /// Corresponds to: `client_secret_basic`
    case clientSecretBasic = "client_secret_basic"

    /// Client authentication using a JWT assertion signed with the client's secret.
    ///
    /// Corresponds to: `client_secret_jwt`
    case clientSecretJWT = "client_secret_jwt"

    /// Client authentication by including the client ID and client secret in the request body.
    ///
    /// Corresponds to: `client_secret_post`
    case clientSecretPost = "client_secret_post"

    /// Public client with no authentication.
    ///
    /// - Important: This method should only be used when the client cannot securely store credentials.
    case none

    /// Client authentication using a JWT assertion signed with a private key (asymmetric).
    ///
    /// Corresponds to: `private_key_jwt`
    case privateKeyJWT = "private_key_jwt"

    /// Client authentication using a self-signed TLS certificate.
    ///
    /// Corresponds to: `self_signed_tls_client_auth`
    case selfSignedTLSClientAuth = "self_signed_tls_client_auth"

    /// Client authentication using a CA-signed TLS certificate.
    ///
    /// Corresponds to: `tls_client_auth`
    case tlsClientAuth = "tls_client_auth"
}
