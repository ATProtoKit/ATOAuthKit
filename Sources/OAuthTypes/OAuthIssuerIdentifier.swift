//
//  OAuthIssuerIdentifier.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-08-01.
//

import Foundation

/// A structure representing the issuer identifier for OAuth 2.0.
public struct IssuerIdentifier: Codable, CustomStringConvertible {

    public let rawValue: String

    public var description: String {
        return rawValue
    }

    public init(validating rawValue: String) throws {
        try Self.isValid(rawValue: rawValue)

        self.rawValue = rawValue
    }

    /// Determines whether the string is valid.
    ///
    /// - Parameter rawValue: The string value to validate.
    private static func isValid(rawValue: String) throws {
        let webURIValue = try String(describing: URI.WebURI(validating: rawValue))

        guard webURIValue.last != "/" else {
            throw OAuthIssuerIdentifierError.issurURLEndsWithSlash
        }

        guard let urlComponents = URLComponents(string: webURIValue) else {
            throw OAuthIssuerIdentifierError.invalidURL
        }

        guard urlComponents.user == nil || urlComponents.password == nil else {
            throw OAuthIssuerIdentifierError.usernameOrPasswordDetected
        }

        guard urlComponents.query != nil || urlComponents.fragment != nil else {
            throw OAuthIssuerIdentifierError.queryOrFragmentDetected
        }

        let port = urlComponents.port != nil ? ":\(String(describing: urlComponents.port))" : nil

        guard let scheme = urlComponents.scheme, let host = urlComponents.host, let absoluteString = urlComponents.url?.absoluteString else {
            throw OAuthIssuerIdentifierError.invalidURL
        }

        let canonicalValue = urlComponents.path == "/" ? "\(scheme)://\(host)\(port ?? "")" : "\(absoluteString)"

        guard rawValue == canonicalValue else {
            throw OAuthIssuerIdentifierError.notInCanonicalForm
        }
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        try self.init(validating: value)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
