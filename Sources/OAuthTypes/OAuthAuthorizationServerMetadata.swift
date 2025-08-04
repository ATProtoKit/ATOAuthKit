//
//  OAuthAuthorizationServerMetadata.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-08-01.
//

import Foundation

/// A structure representing the metadata for an OAuth2 or OpenID Connect authorization server.
public struct AuthorizationServerMetadata: Codable {

    /// The unique identifier for the authorization server.
    public let issuer: IssuerIdentifier

    /// An array of claim names supported by the server. Optional.
    public let claimsSupported: [String]?

    /// An array of language tags for supported claim locales. Optional.
    public let claimsLocalesSupported: [String]?

    /// Indicates if the `claims` parameter is supported by the server. Optional.
    public let isClaimsParameterSupported: Bool?

    /// Indicates if the `request` parameter is supported by the server. Optional.
    public let isRequestParameterSupported: Bool?

    /// Indicates if the `requestURI` parameter is supported by the server. Optional.
    public let isRequestURIParameterSupported: Bool?

    /// Indicates if prior registration of the `request_uri` parameter is required. Optional.
    public let isRequestURIRegistrationRequired: Bool?

    /// An array of OAuth 2.0 scopes supported by the server. Optional.
    public let scopesSupported: [String]?

    /// An array of subject identifier types supported by the server. Optional.
    public let subjectTypesSupported: [String]?

    /// An array of esponse types supported by the server. Optional.
    public let responseTypesSupported: [String]?

    /// An array of response modes supported by the server. Optional.
    public let responseModesSupported: [String]?

    /// An array of OAuth 2.0 grant types supported by the server. Optional.
    public let grantTypesSupported: [String]?

    /// An array of Proof Key for Code Exchange (PKCE) code challenge methods supported by the server. Optional.
    public let codeChallengeMethodsSupported: [OAuthCodeChallengeMethod]?

    /// An array of User Interface locales supported by the server. Optional.
    public let localesSupported: [Locale]?

    /// An array of signing algorithms supported for ID tokens. Optional.
    public let idTokenSigningAlgorithmValuesSupported: [String]?

    /// An array of display values supported by the server for the `display` parameter. Optional.
    public let displayValuesSupported: [String]?

    /// An array of signing algorithms supported for request objects. Optional.
    public let requestObjectSigningAlgorithmValuesSupported: [String]?

    /// Indicates if the `iss` parameter is supported in the authorization response. Optional.
    public let isAuthorizationResponseISSParameterSupported: Bool?

    /// An array of types of authorization details supported by the server. Optional.
    public let authorizationDetailsTypesSupported: [String]?

    /// An array of encryption algorithms supported for request objects. Optional.
    public let requestObjectEncryptionAlgorithmValuesSupported: [String]?

    /// An array of encryption encoding algorithms supported for request objects. Optional.
    public let requestObjectEncryptionENCValuesSupported: [String]?

    /// The URI for the server's JSON Web Key Set (JWKS) document. Optional.
    public let jwksURI: URI.WebURI?

    /// The endpoint for user authorization requests.
    public let authorizationEndpoint: URI.WebURI

    /// The endpoint for token requests.
    public let tokenEndpoint: URI.WebURI

    /// An array of authentication methods supported by the token endpoint.
    ///
    /// Defaults to `["client_secret_basic"]` if omitted.
    public let tokenEndpointAuthMethodsSupported: [String]

    /// An array of signing algorithms supported for client authentication at the token endpoint. Optional.
    public let tokenEndpointAuthSigningAlgorithmValuesSupported: [String]?

    /// The endpoint for token revocation requests. Optional.
    public let revocationEndpoint: URI.WebURI?

    /// The endpoint for token introspection requests. Optional.
    public let introspectionEndpoint: URI.WebURI?

    /// The endpoint for Pushed Authorization Requests (PAR). Optional.
    public let pushedAuthorizationRequestEndpoint: URI.WebURI?

    /// Indicates if pushed authorization requests are required. Optional.
    public let arePushedAuthorizationRequestsRequired: Bool?

    /// The endpoint for retrieving user information. Optional.
    public let userInfoEndpoint: URI.WebURI?

    /// The endpoint for session termination requests. Optional.
    public let endSessionEndpoint: URI.WebURI?

    /// The endpoint for dynamic client registration. Optional.
    public let registrationEndpoint: URI.WebURI?

    /// An array of signing algorithms supported for DPoP (Demonstration of Proof-of-Possession). Optional.
    public let dPopSigningAlgorithmValuesSupported: [String]?

    /// An array of protected resource URIs served by the authorization server. Optional.
    public let protectedResources: [URI.WebURI]?

    /// Indicates if client metadata documents are supported. Optional.
    public let isClientIDMetadataDocumentSupported: Bool?

    public init(
        issuer: IssuerIdentifier,
        claimsSupported: [String]? = nil,
        claimsLocalesSupported: [String]? = nil,
        isClaimsParameterSupported: Bool? = nil,
        isRequestParameterSupported: Bool? = nil,
        isRequestURIParameterSupported: Bool? = nil,
        isRequestURIRegistrationRequired: Bool? = nil,
        scopesSupported: [String]? = nil,
        subjectTypesSupported: [String]? = nil,
        responseTypesSupported: [String]? = nil,
        responseModesSupported: [String]? = nil,
        grantTypesSupported: [String]? = nil,
        codeChallengeMethodsSupported: [OAuthCodeChallengeMethod]? = nil,
        localesSupported: [Locale]? = nil,
        idTokenSigningAlgorithmValuesSupported: [String]? = nil,
        displayValuesSupported: [String]? = nil,
        requestObjectSigningAlgorithmValuesSupported: [String]? = nil,
        isAuthorizationResponseISSParameterSupported: Bool? = nil,
        authorizationDetailsTypesSupported: [String]? = nil,
        requestObjectEncryptionAlgorithmValuesSupported: [String]? = nil,
        requestObjectEncryptionENCValuesSupported: [String]? = nil,
        jwksURI: URI.WebURI? = nil,
        authorizationEndpoint: URI.WebURI,
        tokenEndpoint: URI.WebURI,
        tokenEndpointAuthMethodsSupported: [String] = ["client_secret_basic"],
        tokenEndpointAuthSigningAlgorithmValuesSupported: [String]?,
        revocationEndpoint: URI.WebURI? = nil,
        introspectionEndpoint: URI.WebURI? = nil,
        pushedAuthorizationRequestEndpoint: URI.WebURI? = nil,
        arePushedAuthorizationRequestsRequired: Bool? = nil,
        userInfoEndpoint: URI.WebURI? = nil,
        endSessionEndpoint: URI.WebURI? = nil,
        registrationEndpoint: URI.WebURI? = nil,
        dPopSigningAlgorithmValuesSupported: [String]? = nil,
        protectedResources: [URI.WebURI]? = nil,
        isClientIDMetadataDocumentSupported: Bool? = nil
    ) throws {
        self.issuer = issuer
        self.claimsSupported = claimsSupported
        self.claimsLocalesSupported = claimsLocalesSupported
        self.isClaimsParameterSupported = isClaimsParameterSupported
        self.isRequestParameterSupported = isRequestParameterSupported
        self.isRequestURIParameterSupported = isRequestURIParameterSupported
        self.isRequestURIRegistrationRequired = isRequestURIRegistrationRequired
        self.scopesSupported = scopesSupported
        self.subjectTypesSupported = subjectTypesSupported
        self.responseTypesSupported = responseTypesSupported
        self.responseModesSupported = responseModesSupported
        self.grantTypesSupported = grantTypesSupported
        self.codeChallengeMethodsSupported = codeChallengeMethodsSupported
        self.localesSupported = localesSupported
        self.idTokenSigningAlgorithmValuesSupported = idTokenSigningAlgorithmValuesSupported
        self.displayValuesSupported = displayValuesSupported
        self.requestObjectSigningAlgorithmValuesSupported = requestObjectSigningAlgorithmValuesSupported
        self.isAuthorizationResponseISSParameterSupported = isAuthorizationResponseISSParameterSupported
        self.authorizationDetailsTypesSupported = authorizationDetailsTypesSupported
        self.requestObjectEncryptionAlgorithmValuesSupported = requestObjectEncryptionAlgorithmValuesSupported
        self.requestObjectEncryptionENCValuesSupported = requestObjectEncryptionENCValuesSupported
        self.jwksURI = jwksURI
        self.authorizationEndpoint = authorizationEndpoint
        self.tokenEndpoint = tokenEndpoint
        self.tokenEndpointAuthMethodsSupported = tokenEndpointAuthMethodsSupported
        self.tokenEndpointAuthSigningAlgorithmValuesSupported = tokenEndpointAuthSigningAlgorithmValuesSupported
        self.revocationEndpoint = revocationEndpoint
        self.introspectionEndpoint = introspectionEndpoint
        self.pushedAuthorizationRequestEndpoint = pushedAuthorizationRequestEndpoint
        self.arePushedAuthorizationRequestsRequired = arePushedAuthorizationRequestsRequired
        self.userInfoEndpoint = userInfoEndpoint
        self.endSessionEndpoint = endSessionEndpoint
        self.registrationEndpoint = registrationEndpoint
        self.dPopSigningAlgorithmValuesSupported = dPopSigningAlgorithmValuesSupported
        self.protectedResources = protectedResources
        self.isClientIDMetadataDocumentSupported = isClientIDMetadataDocumentSupported

        try Self.validate(
            arePushedAuthorizationRequestsRequired: arePushedAuthorizationRequestsRequired,
            pushedAuthorizationRequestEndpoint: pushedAuthorizationRequestEndpoint,
            responseTypesSupported: responseTypesSupported,
            tokenEndpointAuthSigningAlgorithmValuesSupported: tokenEndpointAuthSigningAlgorithmValuesSupported
        )
    }

    /// Validates the `struct` to ensure it's in the propert formatting.
    ///
    /// - Parameters:
    ///   - tokenEndpointAuthSigningAlgorithmValuesSupported: An array of signing algorithms supported for client authentication at the token endpoint. Optional.
    ///   - pushedAuthorizationRequestEndpoint: The endpoint for Pushed Authorization Requests (PAR). Optional.
    ///   - responseTypesSupported: The endpoint for Pushed Authorization Requests (PAR). Optional.
    ///   - tokenEndpointAuthSigningAlgorithmValuesSupported: An array of signing algorithms supported for client authentication at the token endpoint. Optional.
    ///
    ///   - Throws: An error if any of the following are true:
    ///     * `arePushedAuthorizationRequestsRequired` is `true` while
    ///     `pushedAuthorizationRequestEndpoint` is `nil`.
    ///     * `responseTypes` is not "code" when `responseTypesSupported` is not `nil`.
    ///     * `none` is used in `tokenEndpointAuthSigningAlgorithmValuesSupported` .
    private static func validate(
        arePushedAuthorizationRequestsRequired: Bool?,
        pushedAuthorizationRequestEndpoint: URI.WebURI?,
        responseTypesSupported: [String]?, tokenEndpointAuthSigningAlgorithmValuesSupported: [String]?
    ) throws {
        if arePushedAuthorizationRequestsRequired == true && pushedAuthorizationRequestEndpoint == nil {
            throw OAuthAuthorizationServerMetadataError.pushedAuthorizationRequestEndpointRequired
        }

        if let responseTypes = responseTypesSupported, !responseTypes.contains("code") {
            throw OAuthAuthorizationServerMetadataError.responseTypeCodeRequired
        }

        if let algorithms = tokenEndpointAuthSigningAlgorithmValuesSupported, algorithms.contains("none") {
            throw OAuthAuthorizationServerMetadataError.tokenEndpointAuthSigningAlgNoneNotAllowed
        }
    }


    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.issuer = try container.decode(IssuerIdentifier.self, forKey: .issuer)
        self.claimsSupported = try container.decodeIfPresent([String].self, forKey: .claimsSupported)
        self.claimsLocalesSupported = try container.decodeIfPresent([String].self, forKey: .claimsLocalesSupported)
        self.isClaimsParameterSupported = try container.decodeIfPresent(Bool.self, forKey: .isClaimsParameterSupported)
        self.isRequestParameterSupported = try container.decodeIfPresent(Bool.self, forKey: .isRequestParameterSupported)
        self.isRequestURIParameterSupported = try container.decodeIfPresent(Bool.self, forKey: .isRequestURIParameterSupported)
        self.isRequestURIRegistrationRequired = try container.decodeIfPresent(Bool.self, forKey: .isRequestURIRegistrationRequired)
        self.scopesSupported = try container.decodeIfPresent([String].self, forKey: .scopesSupported)
        self.subjectTypesSupported = try container.decodeIfPresent([String].self, forKey: .subjectTypesSupported)
        self.responseTypesSupported = try container.decodeIfPresent([String].self, forKey: .responseTypesSupported)
        self.responseModesSupported = try container.decodeIfPresent([String].self, forKey: .responseModesSupported)
        self.grantTypesSupported = try container.decodeIfPresent([String].self, forKey: .grantTypesSupported)
        self.codeChallengeMethodsSupported = try container.decodeIfPresent([OAuthCodeChallengeMethod].self, forKey: .codeChallengeMethodsSupported)
        self.localesSupported = try container.decodeIfPresent([Locale].self, forKey: .localesSupported)
        self.idTokenSigningAlgorithmValuesSupported = try container.decodeIfPresent([String].self, forKey: .idTokenSigningAlgorithmValuesSupported)
        self.displayValuesSupported = try container.decodeIfPresent([String].self, forKey: .displayValuesSupported)
        self.requestObjectSigningAlgorithmValuesSupported = try container.decodeIfPresent([String].self, forKey: .requestObjectSigningAlgorithmValuesSupported)
        self.isAuthorizationResponseISSParameterSupported = try container.decodeIfPresent(Bool.self, forKey: .isAuthorizationResponseISSParameterSupported)
        self.authorizationDetailsTypesSupported = try container.decodeIfPresent([String].self, forKey: .authorizationDetailsTypesSupported)
        self.requestObjectEncryptionAlgorithmValuesSupported = try container
            .decodeIfPresent([String].self, forKey: .requestObjectEncryptionAlgorithmValuesSupported)
        self.requestObjectEncryptionENCValuesSupported = try container.decodeIfPresent([String].self, forKey: .requestObjectEncryptionENCValuesSupported)
        self.jwksURI = try container.decodeIfPresent(URI.WebURI.self, forKey: .jwksURI)
        self.authorizationEndpoint = try container.decode(URI.WebURI.self, forKey: .authorizationEndpoint)
        self.tokenEndpoint = try container.decode(URI.WebURI.self, forKey: .tokenEndpoint)

        let tokenEndpointAuthMethodsSupported = try container.decode([String].self, forKey: .tokenEndpointAuthMethodsSupported)
        if tokenEndpointAuthMethodsSupported == [""] {
            self.tokenEndpointAuthMethodsSupported = ["client_secret_basic"]
        } else {
            self.tokenEndpointAuthMethodsSupported = try container.decode([String].self, forKey: .tokenEndpointAuthMethodsSupported)
        }

        self.tokenEndpointAuthSigningAlgorithmValuesSupported = try container.decodeIfPresent([String].self, forKey: .tokenEndpointAuthSigningAlgorithmValuesSupported)
        self.revocationEndpoint = try container.decodeIfPresent(URI.WebURI.self, forKey: .revocationEndpoint)
        self.introspectionEndpoint = try container.decodeIfPresent(URI.WebURI.self, forKey: .introspectionEndpoint)
        self.pushedAuthorizationRequestEndpoint = try container.decodeIfPresent(URI.WebURI.self, forKey: .pushedAuthorizationRequestEndpoint)
        self.arePushedAuthorizationRequestsRequired = try container.decodeIfPresent(Bool.self, forKey: .arePushedAuthorizationRequestsRequired)
        self.userInfoEndpoint = try container.decodeIfPresent(URI.WebURI.self, forKey: .userInfoEndpoint)
        self.endSessionEndpoint = try container.decodeIfPresent(URI.WebURI.self, forKey: .endSessionEndpoint)
        self.registrationEndpoint = try container.decodeIfPresent(URI.WebURI.self, forKey: .registrationEndpoint)
        self.dPopSigningAlgorithmValuesSupported = try container.decodeIfPresent([String].self, forKey: .dPopSigningAlgorithmValuesSupported)
        self.protectedResources = try container.decodeIfPresent([URI.WebURI].self, forKey: .protectedResources)
        self.isClientIDMetadataDocumentSupported = try container.decodeIfPresent(Bool.self, forKey: .isClientIDMetadataDocumentSupported)
    }

    enum CodingKeys: String, CodingKey {
        case issuer
        case claimsSupported = "claims_supported"
        case claimsLocalesSupported = "claims_locales_supported"
        case isClaimsParameterSupported = "claims_parameter_supported"
        case isRequestParameterSupported = "request_parameter_supported"
        case isRequestURIParameterSupported = "request_uri_parameter_supported"
        case isRequestURIRegistrationRequired = "require_request_uri_registration"
        case scopesSupported = "scopes_supported"
        case subjectTypesSupported = "subject_types_supported"
        case responseTypesSupported = "response_types_supported"
        case responseModesSupported = "response_modes_supported"
        case grantTypesSupported = "grant_types_supported"
        case codeChallengeMethodsSupported = "code_challenge_methods_supported"
        case localesSupported = "ui_locales_supported"
        case idTokenSigningAlgorithmValuesSupported = "id_token_signing_alg_values_supported"
        case displayValuesSupported = "display_values_supported"
        case requestObjectSigningAlgorithmValuesSupported = "request_object_signing_alg_values_supported"
        case isAuthorizationResponseISSParameterSupported = "authorization_response_iss_parameter_supported"
        case authorizationDetailsTypesSupported = "authorization_details_types_supported"
        case requestObjectEncryptionAlgorithmValuesSupported = "request_object_encryption_alg_values_supported"
        case requestObjectEncryptionENCValuesSupported = "request_object_encryption_enc_values_supported"
        case jwksURI = "jwks_uri"
        case authorizationEndpoint = "authorization_endpoint"
        case tokenEndpoint = "token_endpoint"
        case tokenEndpointAuthMethodsSupported = "token_endpoint_auth_methods_supported"
        case tokenEndpointAuthSigningAlgorithmValuesSupported = "token_endpoint_auth_signing_alg_values_supported"
        case revocationEndpoint = "revocation_endpoint"
        case introspectionEndpoint = "introspection_endpoint"
        case pushedAuthorizationRequestEndpoint = "pushed_authorization_request_endpoint"
        case arePushedAuthorizationRequestsRequired = "require_pushed_authorization_requests"
        case userInfoEndpoint = "userinfo_endpoint"
        case endSessionEndpoint = "end_session_endpoint"
        case registrationEndpoint = "registration_endpoint"
        case dPopSigningAlgorithmValuesSupported = "dpop_signing_alg_values_supported"
        case protectedResources = "protected_resources"
        case isClientIDMetadataDocumentSupported = "client_id_metadata_document_supported"
    }
}
