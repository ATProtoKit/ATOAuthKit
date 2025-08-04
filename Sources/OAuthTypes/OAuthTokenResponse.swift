//
//  OAuthTokenResponse.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-08-04.
//

import Foundation

/// A structure representing a token response.
public struct TokenResponse: Codable {

    /// The access token of the response.
    public let accessToken: String

    /// The response's token type.
    public let tokenType: OAuthTokenType

    /// The scope of the token response. Optional.
    public let scope: String?

    /// The refresh token of the response. Optional.
    public let refreshToken: String?

    /// The date and time the response expires. Optional.
    public let expiresIn: Date?

    /// The signed JSON Web Token (JWT). Optional.
    public let idToken: SignedJWT?

    /// Additional authorization details associated with the token response. Optional.
    public let authorizationDetails: AuthorizationDetail?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case idToken = "id_token"
        case authorizationDetails = "authorization_details"
    }
}
