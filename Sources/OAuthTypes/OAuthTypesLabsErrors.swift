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

/// Errors that can occur with respect to authorization response.
///
/// - SeeAlso: https://datatracker.ietf.org/doc/html/draft-ietf-oauth-v2-1-12#name-error-response-2
public enum OAuthAuthorizationResponseError: Error, LocalizedError, CustomStringConvertible {

    /// The request is invalid due to missing or incorrect parameters.
    case invalidRequest

    /// The client is not authorized to request an authorization code using this method.
    case unauthorizedClient

    /// The resource owner or authorization server refused the request.
    case accessDenied

    /// This method is not supported for obtaining an authorization code from the authorization server.
    case unsupportedResponseType

    /// The requested scope is invalid, unknown, or malformed.
    case invalidScope

    /// The authorization server couldn’t fulfill the request due to an unexpected condition.
    ///
    /// This error code is needed because a 500 Internal Server Error HTTP status code can’t be returned to the client via an HTTP redirect.
    case serverError

    /// The authorization server is temporarily overloaded or under maintenance, so it can’t handle the request.
    ///
    /// This error code is needed because a 503 Service Unavailable HTTP status code can’t be returned via an HTTP redirect.
    case temporarilyUnavailable

    public var errorDescription: String? {
        switch self {
            case .invalidRequest:
                return "The request is invalid due to missing or incorrect parameters."
            case .unauthorizedClient:
                return "The client is not authorized to request an authorization code using this method."
            case .accessDenied:
                return "The resource owner or authorization server refused the request."
            case .unsupportedResponseType:
                return "This method is not supported for obtaining an authorization code from the authorization server."
            case .invalidScope:
                return "The requested scope is invalid, unknown, or malformed."
            case .serverError:
                return "The authorization server couldn’t fulfill the request due to an unexpected condition."
            case .temporarilyUnavailable:
                return "The authorization server is temporarily overloaded or under maintenance, so it can’t handle the request."
        }
    }

    public var description: String {
        return errorDescription ?? String(describing: self)
    }
}

/// Errors that can occur with respect to redirect URIs.
public enum OAuthRedirectURIError: Error, LocalizedError, CustomStringConvertible {

    /// Use of `localhost` hostname has been detected in the URI.
    case localhostDetected

    /// The URI lacks either the "http" or "https" protocol.
    case noValidProtocol

    public var errorDescription: String? {
        switch self {
            case .localhostDetected:
                return "'localhost' hostname has been detected and is not allowed. Use a loopback IP such as '127.0.0.1' instead."
            case .noValidProtocol:
                return "The redirect URI must start with either 'http://' or 'https://'."
        }
    }

    public var description: String {
        return errorDescription ?? String(describing: self)
    }
}

/// Errors that can occur with related to ``ClientIDLoop``.
public enum OAuthClientIDLoopbackError: Error, LocalizedError, CustomStringConvertible {

    /// The client ID is invalid.
    ///
    /// - Parameter prefix: The prefix of the client ID.
    case invalidClientID(prefix: String)

    /// A hash component was contained in the loopback client ID.
    case containsHashComponent

    /// A path component was contained in the loopback client ID.
    case containsPathComponent

    /// The query parameter is invalid.
    ///
    /// - Parameter name: The name of the query parameter.
    case invalidQueryParameter(name: String)

    /// There is at least two parameters named `scope`.
    case multipleScopeParameters

    public var errorDescription: String? {
        switch self {
            case .invalidClientID(let prefix):
                return "Loopback Client ID must start with \"\(prefix)\"."
            case .containsHashComponent:
                return "Loopback Client ID cannot contain a hash component."
            case .containsPathComponent:
                return "Loopback Client ID cannot contain a path component."
            case .invalidQueryParameter(let name):
                return "Loopback Client ID cannot contain a query parameter \"\(name)\"."
            case .multipleScopeParameters:
                return "Loopback Client ID cannot contain multiple scope parameters."
        }
    }

    public var description: String {
        return errorDescription ?? String(describing: self)
    }
}

/// Errors that can occur with respect to redirect URIs.
public enum OAuthIssuerIdentifierError: Error, LocalizedError, CustomStringConvertible {

    /// Issuer URL contained a slash (`/`) at the end.
    case issurURLEndsWithSlash

    /// The URL provided was invalid.
    case invalidURL

    /// The URL provided contains a username or password.
    case usernameOrPasswordDetected

    /// The URL provided contains a query or fragment.
    case queryOrFragmentDetected

    /// The URL provided is not in its canonical form.
    case notInCanonicalForm

    public var errorDescription: String? {
        switch self {
            case .issurURLEndsWithSlash:
                return "Issuer URL must not end with a slash."
            case .invalidURL:
                return "The URL provided was invalid."
            case .usernameOrPasswordDetected:
                return "The URL provided should not contain a username or password."
            case .queryOrFragmentDetected:
                return "The URL provided should not contain a query or fragment."
            case .notInCanonicalForm:
                return "The URL provided is not in the canonical form."
        }
    }

    public var description: String {
        return errorDescription ?? String(describing: self)
    }
}

/// Errors that can occur with respect to authorization server metadata.
public enum OAuthAuthorizationServerMetadataError: Error, CustomStringConvertible {

    /// `pushedAuthorizationRequestEndpoint` is required when
    /// `arePushedAuthorizationRequestsRequired`" is `true`.
    case pushedAuthorizationRequestEndpointRequired

    /// Response type `code` is required in `responseTypesSupported`.
    case responseTypeCodeRequired

    /// Client authentication method `none` is not allowed in `tokenEndpointAuthSigningAlgorithmValuesSupported`.
    case tokenEndpointAuthSigningAlgNoneNotAllowed

    public var errorDescription: String? {
        switch self {
            case .pushedAuthorizationRequestEndpointRequired:
                return "\"pushedAuthorizationRequestEndpoint\" required when \"arePushedAuthorizationRequestsRequired\" is true."
            case .responseTypeCodeRequired:
                return "Response type \"code\" is required in \"responseTypesSupported\"."
            case .tokenEndpointAuthSigningAlgNoneNotAllowed:
                return "Client authentication method \"none\" is not allowed in \"tokenEndpointAuthSigningAlgorithmValuesSupported\"."
        }
    }

    public var description: String {
        return errorDescription ?? String(describing: self)
    }
}

/// Errors that can occur with respect to discoverable client IDs.
public enum OAuthClientIDDiscoverableError: Error, LocalizedError, CustomStringConvertible {

    /// The client ID provided doesn't have the "https://" protocol.
    case invlaidURL

    /// The client ID contains a username and/or password.
    case credentialsDetected

    /// The client ID provided does not contain a fragment.
    case containsFragment

    /// The client ID provided does not contain the JSON file name..
    ///
    /// The client ID must end with `/client-metadata.json`.
    case invalidClientMetadataPathComponent

    /// The client ID ends in a trailing slash (`/`)
    case endsInTrailingSlash

    /// The client ID provided is an IP address.
    case containsIPAddress

    /// The client ID's canonical form is not valid.
    ///
    /// - Parameters:
    ///   - expectedValue: The value that's expected.
    ///   - foundValue: The value that was found instead.
    case incorrectCanonicalForm(expectedValue: String, foundValue: String)

    /// The client ID provided contains a port component.
    case containsPort

    /// The client ID provided contains a query component.
    case containsQuery

    /// The client ID provided does not contain the JSON file name.
    ///
    /// The client ID must end with `/oauth-client-metadata.json`.
    case invalidOAuthClientMetadataPathComponent

    public var errorDescription: String? {
        switch self {
            case .invlaidURL:
                return "The client ID URL is invalid."
            case .credentialsDetected:
                return "The client ID must not contain a username or password."
            case .containsFragment:
                return "The client ID must not contain a fragment component."
            case .invalidClientMetadataPathComponent:
                return "The client ID path component must be with `/client-metadata.json`."
            case .endsInTrailingSlash:
                return "The client ID must not end with a trailing slash."
            case .containsIPAddress:
                return "The client ID should not contain an IP address."
            case .incorrectCanonicalForm(let expectedValue, let foundValue):
                return "The client ID canonical form is incorrect. Expected: '\(expectedValue)', found: '\(foundValue)'."
            case .containsPort:
                return "The client ID should not contain a port component."
            case .containsQuery:
                return "The client ID must not contain a query component."
            case .invalidOAuthClientMetadataPathComponent:
                return "The client ID path component must be '/oauth-client-metadata.json'"
        }
    }

    public var description: String {
        return errorDescription ?? String(describing: self)
    }
}

/// Errors that can occur with respect to protected resource metadata.
public enum OAuthProtectedResourceMetadataError: Error, LocalizedError, CustomStringConvertible {

    /// The resource Web URI contains at least one query component.
    case containsQuery

    /// The resource Web URI contains a fragment component.
    case containsFragment

    public var errorDescription: String? {
        switch self {
            case .containsQuery:
                return "The resource web URI should not contain a query component."
            case .containsFragment:
                return "The resource web URI should not contain a fragment component."
        }
    }

    public var description: String {
        return errorDescription ?? String(describing: self)
    }
}

/// Errors that can occur with respect to validations.
public enum ValidationError: Error, LocalizedError, CustomStringConvertible {

    /// The value found was incorrect.
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
