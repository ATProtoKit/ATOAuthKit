//
//  OAuthClientRredentials.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-08-03.
//

/// A structure representing a request body for OAuth 2.0 Client Credentials Bearer token
/// exchanges for a JSON Web Token (JWT).
public struct ClientCredentialsJWTBearer: Codable {

    /// The unique identifier of the client application making the request.
    public let clientID: OAuthClientID

    /// The type of client assertion being used for authentication.
    ///
    /// The value will always be the value of ``clientAssertionTypeJWTBearer``.
    public let clientAssertionType: String = clientAssertionTypeJWTBearer

    /// The signed JSON Web Token (JWT) used as a client assertion.
    public let clientAssertion: SignedJWT

    public init(clientID: OAuthClientID, clientAssertion: SignedJWT) {
        self.clientID = clientID
        self.clientAssertion = clientAssertion
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.clientID = try container.decode(OAuthClientID.self, forKey: .clientID)
        self.clientAssertion = try container.decode(SignedJWT.self, forKey: .clientAssertion)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.clientID, forKey: .clientID)
        try container.encode(self.clientAssertion, forKey: .clientAssertion)
    }

    enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
        case clientAssertion = "client_assertion"
    }
}

/// A structure representing a request body containing confidential client credentials for
/// OAuth authentication.
public struct ClientCredentialsSecretPost: Codable {

    /// The unique identifier assigned to the OAuth client.
    public let clientID: OAuthClientID

    /// The client’s secret key.
    public let clientSecret: String

    enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
        case clientSecret = "client_secret"
    }
}

/// A structure representing a request body containing a public OAuth client identifier, without a
/// client secret.
public struct ClientCredentialsNone: Codable {

    /// The unique identifier assigned to the OAuth client.
    public let clientID: OAuthClientID

    enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
    }
}

///
public enum ClientCredentials: Codable {

    ///
    case clientCredentialsJWTBearer(ClientCredentialsJWTBearer)

    ///
    case clientCredentialsSecretPost(ClientCredentialsSecretPost)

    ///
    case clientCredentialsNone(ClientCredentialsNone)

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let value = try? container.decode(ClientCredentialsJWTBearer.self) {
            self = .clientCredentialsJWTBearer(value)
        } else if let value = try? container.decode(ClientCredentialsSecretPost.self) {
            self = .clientCredentialsSecretPost(value)
        } else if let value = try? container.decode(ClientCredentialsNone.self) {
            self = .clientCredentialsNone(value)
        } else {
            throw DecodingError.typeMismatch(
                JWT.self, DecodingError.Context(
                    codingPath: decoder.codingPath, debugDescription: "Unknown ClientCredentials type"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
            case .clientCredentialsJWTBearer(let value):
                try container.encode(value)
            case .clientCredentialsSecretPost(let value):
                try container.encode(value)
            case .clientCredentialsNone(let value):
                try container.encode(value)
        }
    }
}
