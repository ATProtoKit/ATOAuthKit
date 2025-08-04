//
//  OAuthAuthorizationRequestJar.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-30.
//

/// A structure representing an OAuth Authorization Request JAR.
public struct AuthorizationRequestJAR: Codable {

    /// The JWT request, either signed or unsigned.
    public let request: JWT

    /// Initializes a new `AuthorizationRequestJAR` object from a raw string, automatically detecting the
    /// JWT type.
    ///
    /// Returns `nil` if the string is not a valid JWT in either form.
    public init?(validating rawValue: String) {
        if let signed = SignedJWT(validating: rawValue) {
            self.request = .signed(signed)
        } else if let unsigned = UnsignedJWT(validating: rawValue) {
            self.request = .unsigned(unsigned)
        } else {
            return nil
        }
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)

        guard let instance = Self.init(validating: value) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid AuthorizationRequestJAR value: \(value)"
            )
        }
        self = instance
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(request)
    }
}
