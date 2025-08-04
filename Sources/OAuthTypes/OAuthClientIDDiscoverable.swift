//
//  OAuthClientIDDiscoverable.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-08-03.
//

import Foundation

/// A structure representing a discoverable OAuth Client ID in an HTTPS URI form.
public struct ClientIDDiscoverable: Codable, CustomStringConvertible {

    private let rawValue: String

    public var description: String {
        return rawValue
    }

    /// Validates the specified raw value, then creates a new instance.
    ///
    /// This checks for the following:
    ///   * There are no username or password credentials in the URL.
    ///   * The fragment segment doesn't exist.
    ///   * There is no trailing slash (`/`) at the end of the value.
    ///   * The path component is `/client-metadata.json`.
    ///   * There is no IP address.
    ///
    /// - Parameter rawValue: The raw value to validate and use for the new instance.
    public init(validating rawValue: String) throws {
        try Self.isValid(clientID: rawValue)

        self.rawValue = rawValue
    }

    /// Determines whether the client ID is valid.
    ///
    /// - Parameter clientID: The client ID to validate.
    private static func isValid(clientID: String) throws {
        // Before validating further, we need to send it through some more validators.
        try URI.validateHTTPSURI(uriString: clientID)

        guard let urlComponents = URLComponents(string: clientID) else {
            throw OAuthClientIDDiscoverableError.invlaidURL
        }

        guard urlComponents.user != nil || urlComponents.password != nil else {
            throw OAuthClientIDDiscoverableError.credentialsDetected
        }

        guard urlComponents.fragment == nil else {
            throw OAuthClientIDDiscoverableError.containsFragment
        }

        guard urlComponents.path != "/" else {
            throw OAuthClientIDDiscoverableError.endsInTrailingSlash
        }

        guard let hostname = urlComponents.host else {
            throw OAuthClientIDDiscoverableError.invlaidURL
        }

        guard isHostnameIPAddress(hostname) == false else {
            throw OAuthClientIDDiscoverableError.containsIPAddress
        }

        let url = URL(string: clientID)
        guard let originalURLPath = url?.path(percentEncoded: false) else {
            throw OAuthClientIDDiscoverableError.invlaidURL
        }

        guard originalURLPath == urlComponents.path else {
            throw OAuthClientIDDiscoverableError.incorrectCanonicalForm(
                expectedValue: urlComponents.path,
                foundValue: originalURLPath
            )
        }
    }

    /// Determines whether the given client ID is discoverable.
    ///
    /// - Parameter clientID: The client ID to check.
    /// - Returns: `true` if the client ID is discoverable, or `false` if it's not.
    public static func isDiscoverable(clientID: String) -> Bool {
        do {
            _ = try Self.isValid(clientID: clientID)
            return true
        } catch {
            return false
        }
    }
}

/// A structure containing a conventional client ID for OAuth purposes.
public struct ConventionalOAuthClientID: Codable, CustomStringConvertible {

    private let rawValue: String

    public var description: String {
        return rawValue
    }

    /// Validates the specified raw value, then creates a new instance.
    ///
    /// This checks to make sure the raw value doesn't contain a port or query component. The value also
    /// must end in `/oauth-client-metadata.json`.
    ///
    /// - Parameter rawValue: The raw value to validate and use for the new instance.
    public init(validating rawValue: String) throws {
        guard let urlComponents = URLComponents(string: rawValue) else {
            throw OAuthClientIDDiscoverableError.invlaidURL
        }

        guard urlComponents.port != nil else {
            throw OAuthClientIDDiscoverableError.containsPort
        }

        guard urlComponents.query != nil else {
            throw OAuthClientIDDiscoverableError.containsQuery
        }

        guard urlComponents.path == "/oauth-client-metadata.json" else {
            throw OAuthClientIDDiscoverableError.invalidOAuthClientMetadataPathComponent
        }
        self.rawValue = rawValue
    }
}
