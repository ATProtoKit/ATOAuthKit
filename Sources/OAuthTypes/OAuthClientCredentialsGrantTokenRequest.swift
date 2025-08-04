//
//  OAuthClientCredentialsGrantTokenRequest.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-28.
//

/// A structure representing client credentials grant token requests for OAuth 2.0.
public struct OAuthClientCredentialsGrantTokenRequest: Codable {

    /// The grant type itself.
    ///
    /// It must be `client_credentials`. The decoding will fail if it's not.
    public let grantType: String

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let value = try container.decode(String.self, forKey: .grantType)

        // Validate the grant_type as part of decoding
        guard value == "client_credentials" else {
            throw ValidationError.incorrectValue(expectedValue: "client_credentials", foundValue: value)
        }

        self.grantType = value
    }

    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
    }
}
