//
//  OAuthEndpointName.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-26.
//

/// An enumeration representing the standard OAuth 2.0 endpoint names used within an OAuth server or client.
///
/// `OAuthEndpointName` provides type-safe representations for each major OAuth endpoint. These endpoints
/// are defined in the OAuth 2.0 specification and its extensions, and are commonly used in authentication
/// and authorization flows.
public enum OAuthEndpointName: String {

    /// The endpoint for obtaining an access token.
    ///
    /// The token endpoint is used by the client to obtain an access token by presenting its authorization grant.
    /// This is a required endpoint in the OAuth 2.0 specification.
    case token

    /// The endpoint for revoking an access or refresh token.
    ///
    /// The revocation endpoint allows a client to invalidate a previously obtained token (access
    /// or refresh).
    case revocation

    /// The endpoint for checking the active state of an access token.
    ///
    /// The introspection endpoint allows a protected resource to query the authorization server to
    /// determine the state of an access token and obtain associated metadata.
    case introspection

    /// The endpoint for initiating a Pushed Authorization Request (PAR).
    ///
    /// The pushed authorization request endpoint enables clients to send authorization request parameters
    /// directly to the authorization server, which responds with a reference (`request_uri`) to be used in
    /// subsequent steps.
    case pushedAuthorizationRequest = "pushed_authorization_request"
}
