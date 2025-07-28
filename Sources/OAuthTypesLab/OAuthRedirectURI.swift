//
//  OAuthRedirectURI.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-28.
//

/// A structure representing a loopback redirect URI.
public struct OAuthLoopbackRedirectURI: CustomStringConvertible {
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
}

/// An enumeration that defines the possible types of OAuth redirect URIs.
public enum OAuthRedirectURI {

    /// A loopback redirect URI using the `http://localhost` scheme.
    case oauthLoopbackRedirectURI(OAuthLoopbackRedirectURI)

    /// A secure HTTPS loopback redirect URI.
    case oauthHTTPSRedirectURI(URI.LoopbackRedirectURI)

    /// A private-use URI scheme (custom protocol handler).
    case oauthPrivateUseRedirectURI(URI.PrivateUseURI)

    public init(validating rawValue: String) throws {
        if let value = try? OAuthLoopbackRedirectURI(validating: rawValue) {
            self = .oauthLoopbackRedirectURI(value)
        } else if let value = try? URI.LoopbackRedirectURI(validating: rawValue) {
            self = .oauthHTTPSRedirectURI(value)
        } else if let value = try? URI.PrivateUseURI(validating: rawValue) {
            self = .oauthPrivateUseRedirectURI(value)
        } else {
            throw OAuthRedirectURIError.noValidProtocol
        }
    }
}
