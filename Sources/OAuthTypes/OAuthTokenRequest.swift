//
//  OAuthTokenRequest.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-08-04.
//

/// An enumeration representing all supported OAuth 2.0 token request types.
public enum TokenRequest: Codable {

    /// Represents an OAuth 2.0 Authorization Code Grant token request.
    case oauthAuthorizationCodeGrantTokenRequest(AuthorizationCodeGrantTokenRequest)

    /// Represents an OAuth 2.0 Refresh Token Grant token request.
    case oauthRefreshTokenGrantTokenRequest(RefreshTokenGrantTokenRequest)

    /// Represents an OAuth 2.0 Resource Owner Password Credentials Grant token request.
    case oauthPasswordGrantTokenRequest(OAuthPasswordGrantTokenRequest)

    /// Represents an OAuth 2.0 Client Credentials Grant token request.
    case oauthClientCredentialsGrantTokenRequest(OAuthClientCredentialsGrantTokenRequest)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let grantType = try container.decode(String.self, forKey: .grantType)

        switch grantType {
            case "authorization_code":
                self = .oauthAuthorizationCodeGrantTokenRequest(try AuthorizationCodeGrantTokenRequest(from: decoder))
            case "refresh_token":
                self = .oauthRefreshTokenGrantTokenRequest(try RefreshTokenGrantTokenRequest(from: decoder))
            case "password":
                self = .oauthPasswordGrantTokenRequest(try OAuthPasswordGrantTokenRequest(from: decoder))
            case "client_credentials":
                self = .oauthClientCredentialsGrantTokenRequest(try OAuthClientCredentialsGrantTokenRequest(from: decoder))
            default:
                throw DecodingError.typeMismatch(
                    TokenRequest.self, DecodingError.Context(
                        codingPath: decoder.codingPath, debugDescription: "Unknown TokenRequest type"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
            case .oauthAuthorizationCodeGrantTokenRequest(let value):
                try container.encode(value)
            case .oauthRefreshTokenGrantTokenRequest(let value):
                try container.encode(value)
            case .oauthPasswordGrantTokenRequest(let value):
                try container.encode(value)
            case .oauthClientCredentialsGrantTokenRequest(let value):
                try container.encode(value)
        }
    }

    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
    }
}
