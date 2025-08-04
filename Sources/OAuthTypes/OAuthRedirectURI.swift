//
//  OAuthRedirectURI.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-28.
//

/// A structure representing a loopback redirect URI.
public struct OAuthLoopbackRedirectURI: Codable, CustomStringConvertible {
    public let rawValue: String

    public var description: String {
        return rawValue
    }

    /// Validates the specified raw value, then creates a new instance.
    ///
    /// This checks to see if there's a loopback redirect URI as the hostname. The initializer will fail if
    /// `localhost` is used as the hostname instead.
    ///
    /// - Parameter rawValue: The raw value to validate and use for the new instance.
    public init(validating rawValue: String) throws {
        guard !rawValue.starts(with: "http://localhost") else {
            throw OAuthRedirectURIError.localhostDetected
        }
        self.rawValue = rawValue
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

/// An enumeration that defines the possible types of OAuth redirect URIs.
public enum OAuthRedirectURI: Codable {

    /// A loopback redirect URI using the `http://localhost` scheme.
    case oauthLoopbackRedirectURI(OAuthLoopbackRedirectURI)

    /// A secure HTTPS loopback redirect URI.
    case oauthHTTPSRedirectURI(URI.LoopbackRedirectURI)

    /// A private-use URI scheme (custom protocol handler).
    case oauthPrivateUseRedirectURI(URI.PrivateUseURI)

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)

        if let value = try? OAuthLoopbackRedirectURI(validating: stringValue) {
            self = .oauthLoopbackRedirectURI(value)
        } else if let value = try? URI.LoopbackRedirectURI(validating: stringValue) {
            self = .oauthHTTPSRedirectURI(value)
        } else if let value = try? URI.PrivateUseURI(validating: stringValue) {
            self = .oauthPrivateUseRedirectURI(value)
        } else {
            throw OAuthRedirectURIError.noValidProtocol
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
            case .oauthLoopbackRedirectURI(let value):
                try container.encode(value.rawValue)
            case .oauthHTTPSRedirectURI(let value):
                try container.encode(value.rawValue)
            case .oauthPrivateUseRedirectURI(let value):
                try container.encode(value.rawValue)
        }
    }
}
