//
//  OAuthRequestURI.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-26.
//

/// A structure representing an OAuth request URI.
public struct OAuthRequestURI: RawRepresentable {
    public let rawValue: String

    public init?(rawValue: String) {
        self.rawValue = rawValue
    }
}
