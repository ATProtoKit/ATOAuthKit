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

    /// Validates the URI to ensure it's a loopback URI.
    ///
    /// - Parameter uriString: The URI in its string representation to validate.
    ///
    /// - Throws: An error if the "https" protocol isn't included, or the loopback URI is invalid.
    public static func validateLoopbackURI(uriString: String) throws {
        guard uriString.starts(with: "http://") else {
            throw OAuthTypesLabsURIError.noHTTPProtocol
        }

        guard isLoopbackHost(uriString) else {
            throw OAuthTypesLabsURIError.invalidLoopbackURI
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
    /// This is a method that combines ``validateLoopbackURI(uriString:)``
    /// and ``validateHTTPSURI(uriString:)``.
    ///
    /// - Parameter uriString: The URI in its string representation to validate.
    public static func validateWebURI(uriString: String) throws {
        if uriString.starts(with: "http://") {
            try URI.validateLoopbackURI(uriString: uriString)
        } else if uriString.starts(with: "https://") {
            try URI.validateHTTPSURI(uriString: uriString)
        } else {
            throw OAuthTypesLabsURIError.noHTTPProtocol
        }
    }

    /// Validates the URI for private use.
    ///
    /// - Parameter uri: The URI in its string representation to validate.
    public static func validatePrivateUseURI(uriString: String) throws {
        guard let dotIndex = uriString.firstIndex(of: "."),
              let colonIndex = uriString.firstIndex(of: ":") else {
            throw OAuthTypesLabsURIError.missingDotOrColon
        }

        guard dotIndex < colonIndex else {
            throw OAuthTypesLabsURIError.dotAfterColon
        }

        guard let url = URL(string: uriString) else {
            throw OAuthTypesLabsURIError.invalidURL
        }

        guard url.scheme?.contains(".") != nil else {
            throw OAuthTypesLabsURIError.noValidProtocol
        }

        guard url.host() == nil else {
            throw OAuthTypesLabsURIError.containsHostnameInPrivateUseURI
        }
    }
}
