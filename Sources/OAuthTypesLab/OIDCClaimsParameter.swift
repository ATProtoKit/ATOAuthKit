//
//  OIDCClaimsParameter.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-26.
//

/// The client metadata for each OpenID Connect claim.
public enum OpenIDConnectClaimsParameter: String, CaseIterable, Codable {

    // https://openid.net/specs/openid-provider-authentication-policy-extension-1_0.html#rfc.section.5.2
    /// The date and time when the user last authenticated (as a Unix timestamp).
    ///
    /// This must be used if `isAuthenticatedTimeRequired` is true.
    case authenticatedTime = "auth_time"

    // OpenID Connect core-specific
    /// A unique value provided by the client to mitigate replay attacks.
    ///
    /// This ensures the response belongs to the initiating request.
    case nonce

    /// Indicates the strength or method of authentication.
    ///
    /// This lets clients enforce minimum assurance levels
    case authenticationContextClassReference = "acr"

    // Profile-specifc
    /// The full name of the user.
    case name

    /// The family name of the user.
    ///
    /// Otherwise known as the "last name."
    case familyName = "family_name"

    /// The given name of the user.
    ///
    /// Otehrwise known as the "first name."
    case givenName = "given_name"

    /// The middle name of the user.
    case middleName = "middle_name"

    /// The casual or preferred name.
    case nickname

    /// The username chosen by user.
    case preferredUsername = "preferred_username"

    /// The gender identity of the user.
    case gender

    /// The URL to profile picture.
    case picture

    /// The URL to user's profile page.
    case profile

    /// The URL to the user's website.
    case website

    /// The date and time the user was born.
    case birthdate

    /// The time zone of the user.
    ///
    /// This would typically be in the IANA format.
    case timeZone = "zoneInfo"

    /// The user's preferred language.
    case locale

    /// The date and time the profile was last updated.
    case updatedAt = "updated_at"

    // Email-specific
    /// The email address of the user.
    case email

    /// Determines whether the email address has been verified.
    case isEmailVerified = "email_verified"

    // Phone Number-specific
    /// The phone number of the user.
    case phoneNumber = "phone_number"

    /// Determines whether the phone number has been verified.
    case isPhoneNumberVerified = "phone_number_verified"

    // Address-specific
    /// The physical address of the user.
    case address
}
