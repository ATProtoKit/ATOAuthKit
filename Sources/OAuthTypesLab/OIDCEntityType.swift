//
//  OIDCEntityType.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-25.
//

/// An enumeration representing an OpenID Connect object.
///
/// When processing OpenID Connect data, it helps to distinguish a `userinfo` object (a plain
/// JSON profile) from an `id_token` (JWT token). This distinction helps to apply the correct
/// validation, decoding, and trust rules.
public enum OpenIDConnectEntityType: String {

    /// A user profile object.
    case userInfo = "userinfo"

    /// A identity token object.
    case jwtToken = "id_token"
}
