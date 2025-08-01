//
//  OAuthResponseMode.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-26.
//

/// An enumeration representing the method used to return OAuth authorization responses to
/// the client.
public enum OAuthResponseMode: String, Codable {

    /// The response parameters are encoded in the query string of the redirect URI.
    case query

    /// The response parameters are encoded in the fragment portion of the redirect URI.
    case fragment

    /// The response parameters are encoded as HTML form values and transmitted via HTTP POST
    /// to the client.
    case formPost = "form_post"
}
