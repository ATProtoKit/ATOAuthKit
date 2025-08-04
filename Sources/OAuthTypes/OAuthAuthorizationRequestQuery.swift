//
//  OAuthAuthorizationRequestQuery.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-08-01.
//

/// An enumeration representing the possible forms of an OAuth 2.0 Authorization Request query.
public enum AuthorizationRequestQuery: Codable {

    /// An authorization request expressed directly as a set of parameters.
    case authorizationRequestParameters(AuthorizationRequestParameters)

    /// A  JWT Secured Authorization Request (JAR).
    case authorizationRequestJAR(AuthorizationRequestJAR)

    /// An authorization request via a URI.
    case authorizationRequestURI(AuthorizationRequestURI)

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let value = try? container.decode(AuthorizationRequestParameters.self) {
            self = .authorizationRequestParameters(value)
        } else if let value = try? container.decode(AuthorizationRequestJAR.self) {
            self = .authorizationRequestJAR(value)
        } else if let value = try? container.decode(AuthorizationRequestURI.self) {
            self = .authorizationRequestURI(value)
        } else {
            throw DecodingError.typeMismatch(
                JWT.self, DecodingError.Context(
                    codingPath: decoder.codingPath, debugDescription: "Unknown AuthorizationRequestQuery type"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
            case .authorizationRequestParameters(let value):
                try container.encode(value)
            case .authorizationRequestJAR(let value):
                try container.encode(value)
            case .authorizationRequestURI(let value):
                try container.encode(value)
        }
    }
}
