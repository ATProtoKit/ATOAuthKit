//
//  OAuthScope.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-26.
//

import Foundation

/// An enumeration representing the set of possible OAuth scopes as plain strings.
///
/// Each OAuth scope defines what permissions or access a client is requesting from the user.
/// This enum provides a helper for validating if a given scope string matches the expected
/// pattern, making it easier to check user input or API responses when working with OAuth.
public enum OAuthScope: Equatable, Hashable {

    /// Validates if the input string matches the required pattern for the OAuth scope.
    ///
    /// The input will be valid if it includes a space-separated text of non-control ASCII characters, with
    /// the exception of a backslash (`\`) or double quote (`"`).
    ///
    /// Returns `true` if valid,  or `false` if not.
    public static func isValid(_ scopeInput: String) -> Bool {
        let pattern = #"^[\x21\x23-\x5B\x5D-\x7E]+(?: [\x21\x23-\x5B\x5D-\x7E]+)*$"#

        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let range = NSRange(scopeInput.startIndex..<scopeInput.endIndex, in: scopeInput)

            if let match = regex.firstMatch(in: scopeInput, options: [], range: range) {
                return match.range == range
            } else {
                return false
            }
        } catch {
            // If the regex fails for whatever reason, treat this as false. However, this should
            // never happen.
            return false
        }
    }
}
