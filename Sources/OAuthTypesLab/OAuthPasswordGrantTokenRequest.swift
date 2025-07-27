//
//  OAuthPasswordGrantTokenRequest.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-26.
//

/// A structure representing a password grant token request for OAuth 2.0.
public struct OAuthPasswordGrantTokenRequest: Codable {

    /// The type of token request.
    ///
    /// Will always be `"password"`.
    public let grantType: String = "password"

    /// The username for the token request.
    ///
    /// This should be the identifier required by the OAuth server (often an email or username).
    public let username: String

    /// The password for the token request.
    ///
    /// - Warning: Never log or persist this value outside of secure, short-term memory.
    public let password: String

    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case username
        case password
    }
}
