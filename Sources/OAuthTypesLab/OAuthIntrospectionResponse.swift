//
//  OAuthIntrospectionResponse.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-08-03.
//

import Foundation

/// An enumeration of a response returned from an OAuth 2.0 token introspection endpoint.
public enum OAuthIntrospectionResponse: Codable {

    /// Indicates that the token is inactive.
    case inactive

    /// Indicates that the token is active and includes details about the token.
    case active(OAuthIntrospectionResponseDetails)

    /// Determines whether the introspection response is active.
    var isActive: Bool {
        switch self {
            case .inactive:
                return false
            case .active:
                return true
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let active = try container.decode(Bool.self, forKey: .active)

        switch active {
            case true:
                self = .active(try OAuthIntrospectionResponseDetails(from: decoder))
            case false:
                self = .inactive
        }
    }

    enum CodingKeys: String, CodingKey {
        case active
    }

    /// Details of the introspection response.
    public struct OAuthIntrospectionResponseDetails: Codable {

        /// The scopes granted by this token. Optional.
        public let scope: String?

        /// The client ID associated with this token. Optional.
        public let clientID: String?

        /// The username associated with this token. Optional.
        public let username: String?

        /// The type of token. Optional.
        public let tokenType: OAuthTokenType?

        /// Additional authorization details for this token. Optional.
        public let authorizationDetails: AuthorizationDetail?

        /// An array of audiences for this token. Optional.
        public let audience: [String]?

        /// The date and time the token expires at. Optional.
        public let expiresAt: Date?

        /// The date and time the token was issued. Optional.
        public let issuedAt: Date?

        /// The issuer of the token. Optional.
        public let issuer: String?

        /// A unique identifier for the token. Optional.
        public let jwtID: String?

        /// The earilest date and time at which the token is valid. Optional.
        public let notBefore: Date?

        /// The subject associated with the token. Optional.
        public let subject: String?

        enum CodingKeys: String, CodingKey {
            case scope
            case clientID = "client_id"
            case username
            case tokenType = "token_type"
            case authorizationDetails = "authorization_details"
            case audience = "aud"
            case expiresAt = "exp"
            case issuedAt = "iat"
            case issuer = "iss"
            case jwtID = "jti"
            case notBefore = "nbf"
            case subject = "sub"
        }
    }
}
