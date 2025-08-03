//
//  Utilities.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-24.
//

import Foundation

/// Determines whether the hostname is an IP address.
///
/// - Parameter hostname: The hostname to check on.
/// - Returns: `true` if it's an IP address, or `false` if it's not.
public func isHostnameIPAddress(_ hostname: String) -> Bool {
    // IPv4 regex: '[0-255].[0-255].[0-255].[0-255]'.
    let ipAddressV4Check = #"^(25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)){3}$"#
    if hostname.range(of: ipAddressV4Check, options: .regularExpression) != nil {
        return true
    }

    // IPv6 regex: covers full, shorthand, and mixed notations.
    let ipAddressV6Check = #"^(([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){1,7}:)|(([0-9A-Fa-f]{1,4}:){1,6}:[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){1,5}(:[0-9A-Fa-f]{1,4}){1,2})|(([0-9A-Fa-f]{1,4}:){1,4}(:[0-9A-Fa-f]{1,4}){1,3})|(([0-9A-Fa-f]{1,4}:){1,3}(:[0-9A-Fa-f]{1,4}){1,4})|(([0-9A-Fa-f]{1,4}:){1,2}(:[0-9A-Fa-f]{1,4}){1,5})|([0-9A-Fa-f]{1,4}:((:[0-9A-Fa-f]{1,4}){1,6}))|(:((:[0-9A-Fa-f]{1,4}){1,7}|:))$"#
    if hostname.range(of: ipAddressV6Check, options: .regularExpression) != nil {
        return true
    }

    return false
}

/// An enumeration, representing loopback hosts.
public enum LoopbackHost: String, CaseIterable {

    ///
    case localhost = "localhost"

    ///
    case ipV4 = "127.0.0.1"

    ///
    case ipV6 = "[::1]"
}

/// Checks if a string is a recognized loopback host.
///
/// - Parameter host: The string to check.
/// - Returns: `true` if the string is a loopback host, or `false` if it's not.
public func isLoopbackHost(_ host: String) -> Bool {
    guard let urlHost = URL(string: host)?.host() else { return false }
    return LoopbackHost.allCases.contains { $0.rawValue == urlHost }
}

/// Determines whether the host of the `URL` is a loopback host.
///
/// - Parameter input: The `URL` object to check.
/// - Returns: `true` if it's a loopback address, or `false` if not.
public func isLoopbackURL(_ input: URL) -> Bool {
    guard let host = input.host else {
        return false
    }

    return isLoopbackHost(host)
}

// MARK: ATOAuthKit-specific -

/// A protocol that defines validation for the basic "shape" of a JWT-like token string.
///
/// This protocol provides a method to check if a string conforms to the structural requirements
/// of a JWT (JSON Web Token) or JWT-inspired format, focusing only on the raw string's shape
/// and allowed characters, not on the contents or cryptographic validity of the token.
public protocol JWTShapeValidating {

    /// Validates whether the given string conforms to the expected shape of a JWT-like token.
    ///
    /// This validation includes:
    /// - Ensuring all characters are allowed (A–Z, a–z, 0–9, '+', '/', '=', '.').
    /// - Verifying the number of dot (`.`) separators matches the expected count (e.g., two for a signed
    /// JWT, one for unsigned).
    /// - Requiring the string length to be a multiple of four.
    /// - Ensuring that each section (delimited by dots) is non-empty.
    ///
    /// - Note: This method does **not** validate the contents, padding, or cryptographic signature of the
    /// JWT, nor does it decode or parse its sections. It only checks the shape of the raw value.
    ///
    /// - Parameters:
    ///   - rawValue: The string value to validate.
    ///   - expectedDotCount: The exact number of dot (`.`) characters expected in the string.
    /// - Returns: `true` if the string meets all validation criteria, or `false` if not.
    static func isValidJWTShape(_ rawValue: String, expectedDotCount: Int) -> Bool
}

public extension JWTShapeValidating {
    static func isValidJWTShape(_ rawValue: String, expectedDotCount: Int) -> Bool {
        let base64DotSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=.")

        guard rawValue.unicodeScalars.allSatisfy({ base64DotSet.contains($0) }) else { return false }

        let dotCount = rawValue.filter { $0 == "." }.count
        guard dotCount == expectedDotCount else { return false }

        let parts = rawValue.split(separator: ".", omittingEmptySubsequences: false)
        guard parts.allSatisfy({ !$0.isEmpty }) else { return false }

        return true
    }
}

/// A structure representing a signed JSON Web Token (JWT).
///
/// This includes the header, payload, and signature. This `struct`'s initializer will only check
/// to see if the shape of the JWT exists (that is, a Base64-encoded string with three sections
/// (separated by a dot (`.`)). This does **not** validate the signature, nor does it decode
/// the header and payload.
public struct SignedJWT: CustomStringConvertible, Codable, JWTShapeValidating {
    public let rawValue: String

    public var description: String {
        return rawValue
    }

    /// Validates the specified raw value, then creates a new instance.
    ///
    /// This initializer will check for:
    /// * Whether the string contains three sections, separated by a string.
    /// * Whether the string contains only the characters allowed for Base64.
    ///
    /// - Parameter rawValue: The raw value to validate and use for the new instance.
    public init?(validating rawValue: String) {
        guard Self.isValidJWTShape(rawValue, expectedDotCount: 3) == true else { return nil }
        self.rawValue = rawValue
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)

        guard let instance = Self.init(validating: value) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid SignedJWT value: \(value)"
            )
        }
        self = instance
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

/// A structure representing a signed JSON Web Token (JWT).
///
/// This includes the header and payload. This `struct`'s initializer will only check to see if
/// the shape of the JWT exists (that is, a Base64-encoded string with two sections (separated
/// by a dot (`.`)). This does **not** decode the header and payload.
public struct UnsignedJWT: CustomStringConvertible, Codable, JWTShapeValidating {
    public let rawValue: String

    public var description: String {
        return rawValue
    }

    /// Validates the specified raw value, then creates a new instance.
    ///
    /// This initializer will check for:
    /// * Whether the string contains two sections, separated by a string.
    /// * Whether the string contains only the characters allowed for Base64.
    ///
    /// - Parameter rawValue: The raw value to validate and use for the new instance.
    public init?(validating rawValue: String) {
        guard Self.isValidJWTShape(rawValue, expectedDotCount: 2) == true else { return nil }
        self.rawValue = rawValue
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)

        guard let instance = Self.init(validating: value) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid UnsignedJWT value: \(value)"
            )
        }
        self = instance
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

/// An enum representing either a signed or unsigned JSON Web Token (JWT).
public enum JWT: Codable {

    /// A signed JWT.
    case signed(SignedJWT)

    /// An unsigned JWT.
    case unsigned(UnsignedJWT)

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let value = try? container.decode(SignedJWT.self) {
            self = .signed(value)
        } else if let value = try? container.decode(UnsignedJWT.self) {
            self = .unsigned(value)
        } else {
            throw DecodingError.typeMismatch(
                JWT.self, DecodingError.Context(
                    codingPath: decoder.codingPath, debugDescription: "Unknown JWT type"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
            case .signed(let value):
                try container.encode(value)
            case .unsigned(let value):
                try container.encode(value)
        }
    }
}
