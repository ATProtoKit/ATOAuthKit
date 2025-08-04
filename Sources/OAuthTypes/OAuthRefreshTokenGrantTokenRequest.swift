//
//  OAuthRefreshTokenGrantTokenRequest.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-08-03.
//

/// A structure representing a refresh token grant request.
public struct RefreshTokenGrantTokenRequest: Codable {

    /// The grant type.
    ///
    /// The value will always be `refresh_token`.
    public let grantType: String = "refresh_token"

    /// The refresh token itself.
    public let refreshToken: OAuthRefreshToken

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.refreshToken = try container.decode(OAuthRefreshToken.self, forKey: .refreshToken)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.refreshToken, forKey: .refreshToken)
    }

    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case refreshToken = "refresh_token"
    }
}
