//
//  OAuthTypesLabsErrors.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-24.
//

import Foundation

/// Errors that can occur with respect to URIs.
public enum OAuthTypesLabsURIError: Error, LocalizedError, CustomStringConvertible {

    /// The URL/URI lacks the "http" protocol.
    case noHTTPProtocol

    /// There's no hostname in the URI.
    case noURIHostname

    /// The loopback URI has an invalid hostname.
    case invalidLoopbackURI

    /// The URI/URL lacks the "HTTPS" protocol.
    case noHTTPSProtocol

    /// The URI has less than two segements.
    case lessThanTwoSegementsInURI

    /// The URI ended with `.local`.
    case endsInLocal

    /// The URI lacks either the "http" or "https" protocol.
    case noValidProtocol

    /// The URI doesn't contain a dot (`.`) or a colon (`:`).
    case missingDotOrColon

    /// The URI has a dot (`.`) after the colon (`:`).
    case dotAfterColon

    /// The URI string is not a valid URL.
    case invalidURL

    /// The private-use URI contained a hostname
    case containsHostnameInPrivateUseURI

    public var errorDescription: String? {
        switch self {
            case .noHTTPProtocol:
                return "The URI must start with 'http://'."
            case .noURIHostname:
                return "The URI must contain a hostname."
            case .invalidLoopbackURI:
                return "The URI must be 'http://localhost:8080', '127.0.0.1', or '[::1]' as the hostname."
            case .noHTTPSProtocol:
                return "The URI must start with 'https://'."
            case .lessThanTwoSegementsInURI:
                return "The URI must contain at least two segments."
            case .endsInLocal:
                return "The URI must not end with '.local'."
            case .noValidProtocol:
                return "The URL should contain either the 'http' or https' protocol."
            case .missingDotOrColon:
                return "The URI must contain either a '.' or a ':'."
            case .dotAfterColon:
                return "The URI must not contain a '.' after a ':'."
            case .invalidURL:
                return "The provided string is not a valid URL."
            case .containsHostnameInPrivateUseURI:
                return "Private-use URIs can’t have a hostname. After the protocol, there can only be one slash (as per RFC 8252)."
        }
    }

    public var description: String {
        return errorDescription ?? String(describing: self)
    }
}
