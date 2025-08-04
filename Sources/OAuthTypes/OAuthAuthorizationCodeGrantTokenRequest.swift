//
//  OAuthAuthorizationCodeGrantTokenRequest.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-30.
//

import Foundation

/// A structure representing an OAuth 2.0 authorization code for an access token.
public struct AuthorizationCodeGrantTokenRequest: Codable {

    /// The OAuth 2.0 grant type.
    ///
    /// The value will always be `"authorization_code".
    public let grantType: String = "authorization_code"

    /// The authorization code issued by the authorization server.
    public let code: String

    /// The redirect URI associated with the authorization request.
    public let redirectURI: OAuthRedirectURI

    /// The original code verifier sent during the authorization request. Optional.
    ///
    /// - SeeAlso: https://datatracker.ietf.org/doc/html/rfc7636#section-4.1
    public let codeVerifier: String?

    /// Initializes a new `AuthorizationCodeGrantTokenRequest` object.
    ///
    /// `codeVerifier` must be between 43 and 128 characters and contain only characters from the set
    /// `[A-Z], [a-z], [0-9], and [-._~"]`
    ///
    /// - Parameters:
    ///   -  code: The authorization code issued by the authorization server.
    ///   - redirectURI: The authorization code issued by the authorization server.
    ///   - codeVerifier: The original code verifier sent during the authorization request. Optional.
    public init?(code: String, redirectURI: OAuthRedirectURI, codeVerifier: String? = nil) {
        guard let codeVerifier = codeVerifier else {
            self.code = code
            self.redirectURI = redirectURI
            self.codeVerifier = nil
            return
        }

        // Validate codeVerifier
        guard Self.isValidCodeVerifier(codeVerifier) else {
            return nil // Fails to initialize
        }

        self.code = code
        self.redirectURI = redirectURI
        self.codeVerifier = codeVerifier
    }

    /// Validates a code verifier string.
    ///
    /// This method checks that the code verifier meets the requirements defined in [RFC 7636, Section 4.1](https://datatracker.ietf.org/doc/html/rfc7636#section-4.1):
    ///
    /// - Length must be between 43 and 128 characters.
    /// - Must only use unreserved characters: `[A-Z], [a-z], [0-9], and [-._~"]`.
    ///
    /// - Parameter verifier: The code verifier string to validate.
    /// - Returns: `true` if the verifier is valid, or `false` if not.
    private static func isValidCodeVerifier(_ verifier: String) -> Bool {
        let length = verifier.count
        guard (43...128).contains(length) else { return false }
        let pattern = #"^[a-zA-Z0-9\-._~]+$"#
        return verifier.range(of: pattern, options: .regularExpression) != nil
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let code = try container.decode(String.self, forKey: .code)
        let redirectURI = try container.decode(OAuthRedirectURI.self, forKey: .redirectURI)
        let codeVerifier = try container.decodeIfPresent(String.self, forKey: .codeVerifier)

        if let codeVerifier = codeVerifier, !Self.isValidCodeVerifier(codeVerifier) {
            throw DecodingError.dataCorruptedError(forKey: .codeVerifier, in: container, debugDescription: "Invalid codeVerifier value.")
        }

        self.code = code
        self.redirectURI = redirectURI
        self.codeVerifier = codeVerifier
    }


    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.grantType, forKey: .grantType)
        try container.encode(self.code, forKey: .code)
        try container.encode(self.redirectURI, forKey: .redirectURI)
        try container.encodeIfPresent(self.codeVerifier, forKey: .codeVerifier)
    }

    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case code
        case redirectURI = "redirect_uri"
        case codeVerifier = "code_verifier"
    }
}
