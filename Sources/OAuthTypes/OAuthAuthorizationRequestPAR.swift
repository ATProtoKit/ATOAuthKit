//
//  OAuthAuthorizationRequestPAR.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-08-01.
//

/// An enumeration representing a Pushed Authorization Request (PAR) in OAuth 2.0 or OpenID
/// Connect flows.
public enum OAuthAuthorizationRequestPAR: Codable {

    /// A full set of parameters used in an OAuth 2.0 or OpenID Connect authorization request.
    case authorizationRequestParameters(AuthorizationRequestParameters)

    /// An OAuth Authorization Request JAR.
    case authorizationRequestJAR(AuthorizationRequestJAR)

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let value = try? container.decode(AuthorizationRequestParameters.self) {
            self = .authorizationRequestParameters(value)
        } else if let value = try? container.decode(AuthorizationRequestJAR.self) {
            self = .authorizationRequestJAR(value)
        } else {
            throw DecodingError.typeMismatch(
                JWT.self, DecodingError.Context(
                    codingPath: decoder.codingPath, debugDescription: "Unknown OAuthAuthorizationRequestPAR type"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
            case .authorizationRequestParameters(let value):
                try container.encode(value)
            case .authorizationRequestJAR(let value):
                try container.encode(value)
        }
    }
}
