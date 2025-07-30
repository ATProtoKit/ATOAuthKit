//
//  OAuthClientIDLoopback.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-28.
//

import Foundation

/// A structure representing an OAuth loopback client ID string.
public struct ClientIDLoopback: CustomStringConvertible {

    private let rawValue: String

    public var description: String {
        return rawValue
    }

    /// The required prefix for a valid OAuth loopback client ID.
    ///
    /// This will always have a value of `http://localhost`.
    public static let prefix = "http://localhost"

    /// Validates the specified raw value, then creates a new instance.
    ///
    /// This initializer checks that the provided string is a valid OAuth loopback client ID.
    ///
    /// Validation includes the following:
    /// - Ensures the string starts with the correct prefix (`http://localhost`).
    /// - Verifies only supported query parameters are present (`scope`, `redirect_uri`).
    /// - Checks there are no hash (`#`) components, path components after the prefix, or invalid query parameter names.
    /// - Confirms, the `scope` parameter can be parsed as a valid ``OAuthScope`` (if present).
    /// - Ensures all `redirect_uri` parameters are valid according to ``OAuthLoopbackRedirectURI``.
    ///
    /// - Parameter rawValue: The raw value to validate and use for the new instance.
    public init(validating rawValue: String) throws {
        do {
            _ = try ClientIDLoopback.parse(outhLoopbackClientID: rawValue)
            self.rawValue = rawValue
        } catch let error as OAuthClientIDLoopbackError {
            throw error
        } catch {
            throw OAuthClientIDLoopbackError.invalidClientID(prefix: ClientIDLoopback.prefix)
        }
    }

    /// Determines whether the loopback client ID string can be parsed.
    ///
    /// - Parameter clientID: The client ID string to parse, expected to conform to the loopback format
    /// (starting with ``ClientIDLoop/prefix``).
    ///
    /// - Returns: `true` if it can be parsed, or `false` if not.
    public static func isLoopbackClientID(_ clientID: String) -> Bool {
        do {
            let result = try ClientIDLoopback.parse(outhLoopbackClientID: clientID)
            guard result.scope != nil || result.redirectURIs != nil else {
                return false
            }

            return true
        } catch {
            return false
        }
    }

    /// Parses an OAuth loopback client ID string into its component values.
    ///
    /// - Parameter clientID: The client ID string to parse, expected to conform to the loopback format
    /// (starting with ``ClientIDLoop/prefix``).
    ///
    /// - Returns: A tuple, containing the following:
    ///     * `scope`, which contains the parsed `OAuthScope` if valid, or `nil` if not.
    ///     * `redirectURIs`, which contains `[String]` if valid, or `nil` if not.
    ///
    /// - Throws:
    ///     * `OAuthClientIDLoopbackError.invalidClientID`, if the client ID does not begin with the
    ///     required prefix.
    ///     * `OAuthClientIDLoopbackError.containsHashComponent`, if the client ID contains a hash component
    ///     or is missing a required `?`.
    ///     * `OAuthClientIDLoopbackError.invalidQueryParameter`, if a query parameter other than `scope` or
    ///     `redirect_uri` is found.
    ///     * `OAuthClientIDLoopbackError.multipleScopeParameters`, if more than one `scope` parameter
    ///     is present.
    ///     * `OAuthScope.Error`, if the `scope` parameter cannot be parsed into a valid ``OAuthScope``.
    ///     * Other errors thrown by ``OAuthLoopbackRedirectURI`` validation are caught and ignored (invalid
    ///     URIs are skipped).
    public static func parse(outhLoopbackClientID clientID: String) throws -> (scope: OAuthScope?, redirectURIs: [String]?) {
        guard clientID.starts(with: ClientIDLoopback.prefix) else {
            throw OAuthClientIDLoopbackError.invalidClientID(prefix: ClientIDLoopback.prefix)
        }

        let startOfPathOrQuery = clientID.index(clientID.startIndex, offsetBy: ClientIDLoopback.prefix.count)
        guard !clientID[startOfPathOrQuery...].contains("#") else {
            throw OAuthClientIDLoopbackError.containsHashComponent
        }

        let queryStringIndex = clientID.count > ClientIDLoopback.prefix.count && clientID.character(at: ClientIDLoopback.prefix.count) == "/"
        ? ClientIDLoopback.prefix.count + 1
        : ClientIDLoopback.prefix.count

        if clientID.count == queryStringIndex {
            return (nil, nil)
        }

        guard clientID.character(at: queryStringIndex) == "?" else {
            throw OAuthClientIDLoopbackError.containsPathComponent
        }

        let queryString = String(clientID.dropFirst(queryStringIndex + 1))
        var components = URLComponents()
        components.query = queryString

        guard let items = components.queryItems else {
            return (nil, nil)
        }

        for item in items {
            guard item.name == "redirect_uri" || item.name == "scope" else {
                throw OAuthClientIDLoopbackError.invalidQueryParameter(name: item.name)
            }
        }

        var scope: OAuthScope? = nil
        let scopeItems = items.filter { $0.name == "scope" }

        if scopeItems.count > 1 {
            throw OAuthClientIDLoopbackError.multipleScopeParameters
        } else if let scopeValue = scopeItems.first?.value {
            scope = try OAuthScope(rawValue: scopeValue)
        }

        // 6. Parse redirect_uris (must be valid according to OAuthLoopbackRedirectURI)
        let redirectURIStrings = items.filter { $0.name == "redirect_uri" }.compactMap { $0.value }
        var redirectURIs: [String]? = nil

        if !redirectURIStrings.isEmpty {
            let validated = redirectURIStrings.compactMap { uri in
                try? OAuthLoopbackRedirectURI(validating: uri).rawValue
            }
            if !validated.isEmpty {
                redirectURIs = validated
            }
        }

        if scope == nil && redirectURIs == nil {
            return (nil, nil)
        }

        return (scope: scope, redirectURIs: redirectURIs)
    }
}
