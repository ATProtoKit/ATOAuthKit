//
//  OAuthClientMetadata.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-30.
//

/// Metadata describing the configuration and capabilities of an OAuth client.
///
/// - SeeAlso:
///   * https://openid.net/specs/openid-connect-registration-1_0.html
///   * https://datatracker.ietf.org/doc/html/rfc7591
public struct ClientMetadata: Codable {

    /// An array  of valid redirect URIs for this client, to which the authorization server can
    /// send responses.
    public let redirectURIs: [OAuthRedirectURI]

    /// An array of supported response types for authorization requests.
    public let responseTypes: [OAuthResponse]

    /// Supported OAuth grant types.
    public let grantTypes: [OAuthGrantType]

    /// The scopes requested by the client, defining the access privileges being sought. Optional.
    public let scope: OAuthScope?

    /// The authentication method the client uses at the token endpoint.
    public let tokenEndpointAuthMethod: OAuthEndpointAuthMethod?

    /// The signing algorithm used by the client for authenticating at the token endpoint. Optional.
    public let tokenEndpointAuthSigningAlgorithm: String?

    /// The algorithm used to sign responses from the user info endpoint. Optional.
    public let userInfoSignedResponseAlgorithm: String?

    /// The algorithm used to encrypt responses from the user info endpoint. Optional.
    public let userInfoEncryptedResponseAlgorithm: String?

    /// The URI where the client’s JSON Web Keys can be retrieved. Optional.
    public let jwksURI: URI.WebURI?

    /// The client’s JSON Web Keys. Optional.
    public let jwks: JSONWebKeyContainer?

    /// Indicates whether the client is a web or native application. Optional.
    public let applicationType: ApplicationType?

    /// The type of subject identifier the client expects. Optional.
    public let subjectType: SubjectType?

    /// The signing algorithm used for request objects sent to the authorization server. Optional.
    public let requestObjectSigningAlgorithm: String?

    /// The algorithm used to sign issued ID tokens. Optional.
    public let idTokenSignedResponseAlgorithm: String?

    /// The algorithm used to sign authorization responses. Optional.
    public let authorizationSignedResponseAlgorithm: String?

    /// The content encryption algorithm used for encrypted authorization responses. Optional.
    public let authorizationEncryptedResponseEncoding: String?

    /// The encryption algorithm used for authorization responses. Optional.
    public let authorizationEncryptedResponseAlgorithm: String?

    /// The unique identifier assigned to this OAuth client. Optional.
    public let clientID: OAuthClientID?

    /// The name of the client application, displayed to end users during consent. Optional.
    public let clientName: String?

    /// The client’s home page URI. Optional.
    public let clientURI: URI.WebURI?

    /// URI of the client's privacy policy. Optional.
    public let policyURI: URI.WebURI?

    /// URI of the client’s terms of service. Optional.
    public let termsOfServiceURI: URI.WebURI?

    /// URI of the client’s logo image. Optional.
    public let logoURI: URI.WebURI?

    /// The default maximum authentication age in seconds, specifying how recently the user must
    /// have authenticated.
    public let defaultMaxAge: Int?

    /// Indicates whether the authentication time claim is required in the ID token. Optional.
    public let isAuthTimeRequired: Bool?

    /// An array of contact email addresses for the client application or its administrators. Optional.
    public let contacts: [String]?

    /// Indicates if issued access tokens must be bound to a TLS client certificate. Optional.
    public let isTLSClientCertificateBoundAccessTokens: Bool?

    /// Indicates if issued access tokens are bound to a
    /// DPoP (Demonstration of Proof of Possession) key. Optional.
    public let isDPoPBoundAccessTokens: Bool?

    /// Supported types of authorization details that the client can process. Optional.
    public let authorizationDetailsTypes: [String]?

    /// Represents the type of application, which determines client behavior and allowed redirect URIs.
    public enum ApplicationType: String, Codable {

        /// The client is a web-based application.
        case web = "web"

        /// The client is a native (mobile or desktop) application.
        case native = "native"
    }

    /// Indicates the style of subject identifier used for user privacy and correlation.
    public enum SubjectType: String, Codable {

        /// Use a publicly shared subject identifier.
        case `public`

        /// Use a pairwise identifier, unique to each client to enhance privacy.
        case pairwise
    }

    public init(
        redirectURIs: [OAuthRedirectURI],
        responseTypes: [OAuthResponse] = [.authorizationCodeGrant],
        grantTypes: [OAuthGrantType] = [.authorizationCode],
        scope: OAuthScope?,
        tokenEndpointAuthMethod: OAuthEndpointAuthMethod? = .clientSecretBasic,
        tokenEndpointAuthSigningAlgorithm: String?,
        userInfoSignedResponseAlgorithm: String?,
        userInfoEncryptedResponseAlgorithm: String?,
        jwksURI: URI.WebURI?,
        jwks: JSONWebKeyContainer?,
        applicationType: ApplicationType? = .web,
        subjectType: SubjectType? = .public,
        requestObjectSigningAlgorithm: String?,
        idTokenSignedResponseAlgorithm: String?,
        authorizationSignedResponseAlgorithm: String? = "RS256",
        authorizationEncryptedResponseEncoding: String? = "A128CBC-HS256",
        authorizationEncryptedResponseAlgorithm: String?,
        clientID: OAuthClientID?,
        clientName: String?,
        clientURI: URI.WebURI?,
        policyURI: URI.WebURI?,
        termsOfServiceURI: URI.WebURI?,
        logoURI: URI.WebURI?,
        defaultMaxAge: Int?,
        isAuthTimeRequired: Bool?,
        contacts: [String]?,
        isTLSClientCertificateBoundAccessTokens: Bool?,
        isDPoPBoundAccessTokens: Bool?,
        authorizationDetailsTypes: [String]?
    ) {
        self.redirectURIs = redirectURIs
        self.responseTypes = responseTypes
        self.grantTypes = grantTypes
        self.scope = scope
        self.tokenEndpointAuthMethod = tokenEndpointAuthMethod
        self.tokenEndpointAuthSigningAlgorithm = tokenEndpointAuthSigningAlgorithm
        self.userInfoSignedResponseAlgorithm = userInfoSignedResponseAlgorithm
        self.userInfoEncryptedResponseAlgorithm = userInfoEncryptedResponseAlgorithm
        self.jwksURI = jwksURI
        self.jwks = jwks
        self.applicationType = applicationType
        self.subjectType = subjectType
        self.requestObjectSigningAlgorithm = requestObjectSigningAlgorithm
        self.idTokenSignedResponseAlgorithm = idTokenSignedResponseAlgorithm
        self.authorizationSignedResponseAlgorithm = authorizationSignedResponseAlgorithm
        self.authorizationEncryptedResponseEncoding = authorizationEncryptedResponseEncoding
        self.authorizationEncryptedResponseAlgorithm = authorizationEncryptedResponseAlgorithm
        self.clientID = clientID
        self.clientName = clientName
        self.clientURI = clientURI
        self.policyURI = policyURI
        self.termsOfServiceURI = termsOfServiceURI
        self.logoURI = logoURI
        self.defaultMaxAge = defaultMaxAge
        self.isAuthTimeRequired = isAuthTimeRequired
        self.contacts = contacts
        self.isTLSClientCertificateBoundAccessTokens = isTLSClientCertificateBoundAccessTokens
        self.isDPoPBoundAccessTokens = isDPoPBoundAccessTokens
        self.authorizationDetailsTypes = authorizationDetailsTypes
    }

    enum CodingKeys: String, CodingKey {
        case redirectURIs = "redirect_uris"
        case responseTypes = "response_types"
        case grantTypes = "grant_types"
        case scope
        case tokenEndpointAuthMethod = "token_endpoint_auth_method"
        case tokenEndpointAuthSigningAlgorithm = "token_endpoint_auth_signing_alg"
        case userInfoSignedResponseAlgorithm = "userinfo_signed_response_alg"
        case userInfoEncryptedResponseAlgorithm = "userinfo_encrypted_response_alg"
        case jwksURI = "jwks_uri"
        case jwks
        case applicationType = "application_type"
        case subjectType = "subject_type"
        case requestObjectSigningAlgorithm = "request_object_signing_alg"
        case idTokenSignedResponseAlgorithm = "id_token_signed_response_alg"
        case authorizationSignedResponseAlgorithm = "authorization_signed_response_alg"
        case authorizationEncryptedResponseEncoding = "authorization_encrypted_response_enc"
        case authorizationEncryptedResponseAlgorithm = "authorization_encrypted_response_alg"
        case clientID = "client_id"
        case clientName = "client_name"
        case clientURI = "client_uri"
        case policyURI = "policy_uri"
        case termsOfServiceURI = "tos_uri"
        case logoURI = "logo_uri"
        case defaultMaxAge = "default_max_age"
        case isAuthTimeRequired = "require_auth_time"
        case contacts
        case isTLSClientCertificateBoundAccessTokens = "tls_client_certificate_bound_access_tokens"
        case isDPoPBoundAccessTokens = "dpop_bound_access_tokens"
        case authorizationDetailsTypes = "authorization_details_types"
    }
}
