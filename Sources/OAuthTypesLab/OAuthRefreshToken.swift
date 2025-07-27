//
//  OAuthRefreshToken.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-26.
//

/// A structure representing refresh tokens in OAuth.
public struct OAuthRefreshToken: RawRepresentable {
    public let rawValue: String

    public init?(rawValue: String) {
        guard rawValue.count > 0 else { return nil }
        self.rawValue = rawValue
    }
}
