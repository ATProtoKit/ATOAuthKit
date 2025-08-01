//
//  OAuthAuthorizationRequestJar.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-30.
//

/// A structure representing an OAuth Authorization Request JAR.
public struct AuthorizationRequestJAR {

    /// The JWT request, either signed or unsigned.
    public let request: JWT

    /// Initializes a new `AuthorizationRequestJAR` object from a raw string, automatically detecting the
    /// JWT type.
    ///
    /// Returns `nil` if the string is not a valid JWT in either form.
    public init?(rawValue: String) {
        if let signed = SignedJWT(validating: rawValue) {
            self.request = .signed(signed)
        } else if let unsigned = UnsignedJWT(validating: rawValue) {
            self.request = .unsigned(unsigned)
        } else {
            return nil
        }
    }
}
