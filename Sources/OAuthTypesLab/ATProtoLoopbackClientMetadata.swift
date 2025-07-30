//
//  ATProtoLoopbackClientMetadata.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-30.
//

/// Creates a ``ClientMetadata`` object specifically tailored for the AT Protocol.
///
/// - Parameter clientID: The client ID to extract.
///
/// - Returns: A ``ClientMetadata`` object, specifically tailored for the AT Protocol.
public func makeATProtoLoopbackClientMetadata(clientID: String) throws -> ClientMetadata {
    let parsedResult = try ClientIDLoopback.parse(outhLoopbackClientID: clientID)
    let scope = try parsedResult.scope ?? OAuthScope(validating: "atproto")
    let redirectURIs = parsedResult.redirectURIs ?? ["http://127.0.0.1/", "http://[::1]/"]

    // We need to add the redirect URIs to the containers in order to add them to the client metadata.
    var validatedRedirectURIs: [OAuthRedirectURI] = []

    for redirectURI in redirectURIs {
        let uri = try OAuthLoopbackRedirectURI(validating: redirectURI)
        let validatedRedirectURI = OAuthRedirectURI.oauthLoopbackRedirectURI(uri)

        validatedRedirectURIs.append(validatedRedirectURI)
    }

    let clientMetadata = ClientMetadata(
        redirectURIs: validatedRedirectURIs,
        responseTypes: [.authorizationCodeGrant],
        grantTypes: [.authorizationCode, .refreshToken],
        scope: scope,
        tokenEndpointAuthMethod: OAuthEndpointAuthMethod.none,
        applicationType: .native,
        clientID: OAuthClientID(validating: clientID),
        isDPoPBoundAccessTokens: true,
    )

    return clientMetadata
}
