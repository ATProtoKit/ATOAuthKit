//
//  OAuthAuthorizationRequestURI.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-08-01.
//

/// A structure representing an authorization request URI.
public struct AuthorizationRequestURI: Codable {

    /// The request URI of the authorization request.
    public let requestURI: OAuthRequestURI

    enum CodingKeys:String, CodingKey {
        case requestURI = "request_uri"
    }
}
