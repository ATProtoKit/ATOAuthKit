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

/// Errors that can occur with respect to authorization responses.
///
/// - SeeAlso: https://openid.net/specs/openid-connect-core-1_0.html#AuthError
public enum OAuthTypesLabsAuthorizationResponseError: Error, LocalizedError, CustomStringConvertible {

    /// The authorization server needs user interaction to proceed.
    ///
    /// This error may occur when the prompt parameter in the authentication request is none, but the
    /// request can’t be completed without a user interface.
    case interactionRequired

    /// The authorization server needs authentication by the user.
    ///
    /// This error may occur when the prompt parameter in the authentication request is none, but the
    /// request can’t be completed without a user interface for user authentication.
    case loginRequired

    /// The user must select a session at the authorization server.
    ///
    /// They can authenticate with different accounts, but they didn’t select a session. This error occurs
    /// when the prompt parameter in the authentication request is none, but the Authentication Request
    /// needs a user interface to prompt for a session.
    case accountSelectionRequired

    /// The authorization server needs consent from the user.
    ///
    /// This error may occur when the prompt parameter value in the authentication request is none, but the
    /// authentication request can’t be completed without showing a user interface for user consent.
    case consentRequired

    /// The authorization request’s `requestURI` is invalid or returns an error.
    case invalidRequestURI

    /// The request parameter is invalid.
    case invalidRequestObject

    /// The OpenID Provider opposes the use of the request parameter specified in Section 6.
    case requestNotSupported

    /// The OpenID Provider opposes the use of the `requestURI` parameter specified in Section 6.
    case requestURINotSupported

    /// The OpenID Provider opposes the use of the registration parameter specified in Section 7.2.1.
    case registrationNotSupported

    public var errorDescription: String? {
        switch self {
            case .interactionRequired:
                return "The authorization server requires interaction with the user."
            case .loginRequired:
                return "The user must log in to the authorization server."
            case .accountSelectionRequired:
                return "The user must select an account."
            case .consentRequired:
                return "The user must consent to the authorization request."
            case .invalidRequestURI:
                return "The authorization request's `requestURI` is invalid or returns an error."
            case .invalidRequestObject:
                return "The request parameter is invalid."
            case .requestNotSupported:
                return "The authorization server does not support the use of the 'request' parameter in this context."
            case .requestURINotSupported:
                return "The authorization server does not support the use of the 'requestURI' parameter in this context."
            case .registrationNotSupported:
                return "The authorization server does not support the use of the 'registration' parameter in this context."
        }
    }

    public var description: String {
        return errorDescription ?? String(describing: self)
    }
}

/// Errors that can occur with respect to validations.
public enum ValidationError: Error, LocalizedError, CustomStringConvertible {

    /// THe value found was incorrect.
    ///
    /// - Parameters:
    ///   - expectedValue: The value expected to be found.
    ///   - foundValue: The value that was found instead.
    case incorrectValue(expectedValue: String, foundValue: String)

    public var errorDescription: String? {
        switch self {
            case .incorrectValue(let expectedValue, let foundValue):
                return "Incorrect value. Expected: '\(expectedValue)', found: '\(foundValue)'."
        }
    }

    public var description: String {
        return errorDescription ?? String(describing: self)
    }
}
