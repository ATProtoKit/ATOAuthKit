//
//  OAuthAccessToken.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-28.
//

/// A structure representing an OAuth access token.
public struct OAuthAccessToken: RawRepresentable {

    public let rawValue: String

    public init?(rawValue: String) {
        self.rawValue = rawValue
    }
}
