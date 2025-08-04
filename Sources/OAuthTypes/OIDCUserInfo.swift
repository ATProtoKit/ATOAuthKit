//
//  OIDCUserInfo.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-25.
//

import Foundation

/// A structure representing the user information for OpenID Connect.
public struct OpenIDConnectUserInfo: Codable {

    /// The end user within the identity provider (the `sub` claim).
    ///
    /// This is how the application knows which user has authenticated.
    public let subject: String

    /// The unique identifier of the identity provider (the `iss` claim). Optional.
    ///
    /// This is so the client can identify who issued the token.
    public let issuer: URL?

    /// The intended recipient(s) for this token (the `aud` claim). Optional.
    ///
    /// This will ensure the token is being used by the right client. Optional.
    public let audience: [String]?

    /// The email address of the subject. Optional.
    public let email: String?

    /// Determines whether the email has been verified. Optional.
    ///
    /// This fits into the `email_verified` claim.
    public let isEmailVerified: Bool?

    /// The subject's name. Optional.
    public let name: String?

    /// The preferred username of the subject. Optional.
    ///
    /// This fits into the `preferred_username` claim.
    public let preferredUsername: String?

    /// A URL of the subject's photo. Optional.
    ///
    /// This would typically be used for the profile picture.
    public let picture: URL?

    enum CodingKeys: String, CodingKey {
        case subject = "sub"
        case issuer = "iss"
        case audience = "aud"
        case email
        case isEmailVerified = "email_verified"
        case name
        case preferredUsername = "preferred_username"
        case picture
    }
}
