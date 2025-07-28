//
//  URI.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-24.
//

import Foundation

///
public enum URI {

    /// Determines whether the URL can be parsed.
    ///
    /// - Parameter url: The URL in its `String` representation.
    /// - Returns: `true` if it can be parsed, or `false` if not.
    public static func canParseURL(_ url: String) -> Bool {
        guard URL(string: url) != nil else { return false }
        return true
    }

    /// Determines whether the URI in its string representation is a dangerous URI
    ///
    /// Common URIs include `javascript:`, `file:`, `data:` etc.
    ///
    /// - Parameter uriString: The URI to check.
    /// - Returns: `true` if it is a dangerous URI, or `false` if not.
    public static func isDangerousURI(uriString: String) -> Bool {
        guard uriString.contains(":") else { return false }
        guard let url = URL(string: uriString), url.scheme != nil else { return false }
        return true
    }

    /// A structure representing a loopback redirect URI.
    public struct LoopbackRedirectURI {
        public let rawValue: String

        public var description: String {
            return rawValue
        }

        /// Validates the specified raw value, then creates a new instance.
        ///
        /// This checks to see if there's a loopback redirect URI as the hostname.
        ///
        /// - Parameter rawValue: The raw value to validate and use for the new instance.
        public init(validating rawValue: String) throws {
            guard rawValue.starts(with: "http://") else {
                throw OAuthTypesLabsURIError.noHTTPProtocol
            }

            guard isLoopbackHost(rawValue) else {
                throw OAuthTypesLabsURIError.invalidLoopbackURI
            }

            self.rawValue = rawValue
        }
    }

    /// Validates HTTP URIs.
    ///
    /// If nothing happens, it means the string has been validated.
    ///
    /// - Parameter uriString: The URI in its string representation to validate.
    ///
    /// - Throws: An error if the "https" protocol isn't used, the loopback host is invalid,
    /// the URI lacks two segments, or it ends with `.local`.
    public static func validateHTTPSURI(uriString: String) throws {
        guard uriString.starts(with: "https://") else {
            throw OAuthTypesLabsURIError.noHTTPSProtocol
        }

        guard isLoopbackHost(uriString) else {
            throw OAuthTypesLabsURIError.invalidLoopbackURI
        }

        guard let uriHost = URL(string: uriString)?.host() else {
            throw OAuthTypesLabsURIError.noURIHostname
        }

        if !isHostnameIPAddress(uriString) {
            if !uriHost.contains(".") {
                throw OAuthTypesLabsURIError.lessThanTwoSegementsInURI
            }

            if uriHost.contains(".local") {
                throw OAuthTypesLabsURIError.noURIHostname
            }
        }
    }

    /// Validates a web URI.
    ///
    /// This is a method that combines ``LoopbackRedirectURI/init(validating:)``
    /// and ``validateHTTPSURI(uriString:)``.
    ///
    /// - Parameter uriString: The URI in its string representation to validate.
    public static func validateWebURI(uriString: String) throws {
        if uriString.starts(with: "http://") {
            _ = try URI.LoopbackRedirectURI(validating: uriString)
        } else if uriString.starts(with: "https://") {
            try URI.validateHTTPSURI(uriString: uriString)
        } else {
            throw OAuthTypesLabsURIError.noHTTPProtocol
        }
    }

    ///
    public struct PrivateUseURI {
        public let rawValue: String

        public var description: String {
            return rawValue
        }

        /// Validates the specified raw value, then creates a new instance.
        ///
        /// This checks to see if the value is a private use URI. The initializer will fail if:
        /// * there's a missing dot (`.`) or colon (`:`),
        /// * there's a dot {`.`) _after_ the colon (`:`),
        /// * the URL is invalid,
        /// * the protocol is invalid, or
        /// * the hostname exists in the URI.
        ///
        /// - Parameter rawValue: The raw value to validate and use for the new instance.
        public init(validating rawValue: String) throws {
            guard let dotIndex = rawValue.firstIndex(of: "."),
                  let colonIndex = rawValue.firstIndex(of: ":") else {
                throw OAuthTypesLabsURIError.missingDotOrColon
            }

            guard dotIndex < colonIndex else {
                throw OAuthTypesLabsURIError.dotAfterColon
            }

            guard let url = URL(string: rawValue) else {
                throw OAuthTypesLabsURIError.invalidURL
            }

            guard url.scheme?.contains(".") == true else {
                throw OAuthTypesLabsURIError.noValidProtocol
            }

            guard url.host() == nil else {
                throw OAuthTypesLabsURIError.containsHostnameInPrivateUseURI
            }

            self.rawValue = rawValue
        }
    }
}
