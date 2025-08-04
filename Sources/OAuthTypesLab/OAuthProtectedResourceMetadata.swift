//
//  OAuthProtectedResourceMetadata.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-08-03.
//

/// A structure representing metadata describing a protected OAuth 2.0 resource.
///
/// - SeeAlso: https://datatracker.ietf.org/doc/html/draft-ietf-oauth-resource-metadata-05#name-protected-resource-metadata-r
public struct ProtectedResourceMetadata: Codable {

    /// The resource's unique identifier.
    ///
    /// This must be an HTTPS URL with no query or fragment components.
    ///
    /// - Note: Non-HTTPS URLs may be used during development or testing,
    /// but should be rejected in production.
    public let resource: URI.WebURI

    /// An array of authorization server issuer identifiers supported by this resource. Optional.
    public let authorizationServers: [IssuerIdentifier]?

    /// URL of the resource's JSON Web Key Set (JWKS) document. Optional.
    public let jwksURI: URI.WebURI?

    /// An array of OAuth 2.0 scopes supported by this resource Optional.
    public let scopesSupported: [String]?

    /// Supported methods for sending a Bearer token to the resource. Optional.
    public let bearerMethodsSupported: BearerMethodsSupported?

    /// An array of supported JSON Web Key Set (JWKS) signing algorithms for resource responses.
    /// Optional.
    public let resourceSigningAlgorithmValuesSupported: [String]?

    /// URL of human-readable documentation for developers using this resource. Optional.
    public let resourceDocumentation: URI.WebURI?

    /// URL describing the resource's usage policy. Optional.
    public let resourcePolicyURI: URI.WebURI?

    /// URL describing the resource's terms of service. Optional.
    public let resourceTermsOfServiceURI: URI.WebURI?

    public init(
        resource: URI.WebURI,
        authorizationServers: [IssuerIdentifier]? = nil,
        jwksURI: URI.WebURI? = nil,
        scopesSupported: [String]? = nil,
        bearerMethodsSupported: BearerMethodsSupported? = nil,
        resourceSigningAlgorithmValuesSupported: [String]? = nil,
        resourceDocumentation: URI.WebURI? = nil,
        resourcePolicyURI: URI.WebURI? = nil,
        resourceTermsOfServiceURI: URI.WebURI? = nil
    ) throws {
#if !DEBUG
        if String(describing: resource).contains("?") {
            throw OAuthProtectedResourceMetadataError.containsQuery
        }

        if String(describing: resource).contains("#") {
            throw OAuthProtectedResourceMetadataError.containsFragment
        }
#endif
        self.resource = resource
        self.authorizationServers = authorizationServers
        self.jwksURI = jwksURI
        self.scopesSupported = scopesSupported
        self.bearerMethodsSupported = bearerMethodsSupported
        self.resourceSigningAlgorithmValuesSupported = resourceSigningAlgorithmValuesSupported
        self.resourceDocumentation = resourceDocumentation
        self.resourcePolicyURI = resourcePolicyURI
        self.resourceTermsOfServiceURI = resourceTermsOfServiceURI
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let decodedResource = try container.decode(URI.WebURI.self, forKey: .resource)
#if !DEBUG
        if String(describing: decodedResource).contains("?") {
            throw OAuthProtectedResourceMetadataError.containsQuery
        }

        if String(describing: decodedResource).contains("#") {
            throw OAuthProtectedResourceMetadataError.containsFragment
        }
#endif
        self.resource = decodedResource
        self.authorizationServers = try container.decodeIfPresent([IssuerIdentifier].self, forKey: .authorizationServers)
        self.jwksURI = try container.decodeIfPresent(URI.WebURI.self, forKey: .jwksURI)
        self.scopesSupported = try container.decodeIfPresent([String].self, forKey: .scopesSupported)
        self.bearerMethodsSupported = try container.decodeIfPresent(ProtectedResourceMetadata.BearerMethodsSupported.self, forKey: .bearerMethodsSupported)
        self.resourceSigningAlgorithmValuesSupported = try container.decodeIfPresent([String].self, forKey: .resourceSigningAlgorithmValuesSupported)
        self.resourceDocumentation = try container.decodeIfPresent(URI.WebURI.self, forKey: .resourceDocumentation)
        self.resourcePolicyURI = try container.decodeIfPresent(URI.WebURI.self, forKey: .resourcePolicyURI)
        self.resourceTermsOfServiceURI = try container.decodeIfPresent(URI.WebURI.self, forKey: .resourceTermsOfServiceURI)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.resource, forKey: .resource)
        try container.encodeIfPresent(self.authorizationServers, forKey: .authorizationServers)
        try container.encodeIfPresent(self.jwksURI, forKey: .jwksURI)
        try container.encodeIfPresent(self.scopesSupported, forKey: .scopesSupported)
        try container.encodeIfPresent(self.bearerMethodsSupported, forKey: .bearerMethodsSupported)
        try container.encodeIfPresent(self.resourceSigningAlgorithmValuesSupported, forKey: .resourceSigningAlgorithmValuesSupported)
        try container.encodeIfPresent(self.resourceDocumentation, forKey: .resourceDocumentation)
        try container.encodeIfPresent(self.resourcePolicyURI, forKey: .resourcePolicyURI)
        try container.encodeIfPresent(self.resourceTermsOfServiceURI, forKey: .resourceTermsOfServiceURI)
    }

    enum CodingKeys: String, CodingKey {
        case resource
        case authorizationServers = "authorization_servers"
        case jwksURI = "jwks_uri"
        case scopesSupported = "scopes_supported"
        case bearerMethodsSupported = "bearer_methods_supported"
        case resourceSigningAlgorithmValuesSupported = "resource_signing_alg_values_supported"
        case resourceDocumentation = "resource_documentation"
        case resourcePolicyURI = "resource_policy_uri"
        case resourceTermsOfServiceURI = "resource_tos_uri"
    }

    /// Supported methods for sending a Bearer token to the resource.
    public enum BearerMethodsSupported: String, Codable {

        /// Send the Bearer token in the `Authorization` HTTP header.
        case header

        /// Send the Bearer token in the request body.
        case body

        /// Send the Bearer token as a query parameter in the request URL.
        case query
    }
}
