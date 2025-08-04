//
//  OAuthTokenIdentification.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-08-03.
//

/// An enumeration represents a request to identify an OAuth token for introspection or
/// revocation purposes.
public struct TokenIdentification: Codable {

    /// The actual OAuth token string.
    public let token: Token

    /// A hint to help the server identify the type of token being sent.
    public let tokenTypeHint: TokenTypeHint

    /// A representation of possible OAuth token variants.
    public enum Token: Codable {

        /// An OAuth access token.
        case accessToken(OAuthAccessToken)

        /// An OAuth refresh token
        case refreshToken(OAuthRefreshToken)

        public init(from decoder: any Decoder) throws {
            let container = try decoder.singleValueContainer()

            if let value = try? container.decode(OAuthAccessToken.self) {
                self = .accessToken(value)
            } else if let value = try? container.decode(OAuthRefreshToken.self) {
                self = .refreshToken(value)
            } else {
                throw DecodingError.typeMismatch(
                    JWT.self, DecodingError.Context(
                        codingPath: decoder.codingPath, debugDescription: "Unknown ClientCredentials type"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()

            switch self {
                case .accessToken(let value):
                    try container.encode(value)
                case .refreshToken(let value):
                    try container.encode(value)
            }
        }
    }

    /// A representation of valid hints for token type when identifying an OAuth token.
    public enum TokenTypeHint: String, Codable {

        /// Indicates that the provided token is an access token.
        case accessToken = "access_token"

        /// Indicates that the provided token is a refresh token.
        case refreshToken = "refresh_token"
    }
}
