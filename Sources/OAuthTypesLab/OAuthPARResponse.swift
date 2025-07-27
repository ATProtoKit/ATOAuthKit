//
//  OAuthPARResponse.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-26.
//

///
public struct OAuthPARResponse: Codable {

    /// The request URI of the PAR response.
    public let requestURI: String

    /// The date and time it will expire (in a UNIX timestamp).
    ///
    /// This will always be a positive number.
    public let expiresIn: Int

    /// Creates an instance of `OAuthPARResponse`.
    ///
    /// If a negative number is inserted into `expiresIn`, it will be converted to a positive number.
    ///
    /// - Parameters:
    ///   - requestURI: The request URI of the PAR response.
    ///   - expiresIn: This will always be a positive number.
    public init(requestURI: String, expiresIn: Int) {
        self.requestURI = requestURI
        self.expiresIn = abs(expiresIn)
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.requestURI = try container.decode(String.self, forKey: .requestURI)
        self.expiresIn = abs(try container.decode(Int.self, forKey: .expiresIn))
    }
}
