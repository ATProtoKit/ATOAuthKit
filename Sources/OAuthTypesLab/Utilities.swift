//
//  Utilities.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-24.
//

import Foundation

/// Determines whether the hostname is an IP address.
///
/// - Parameter hostname: The hostname to check on.
/// - Returns: `true` if it's an IP address, or `false` if it's not.
public func isHostnameIPAddress(_ hostname: String) -> Bool {
    // IPv4 regex: '[0-255].[0-255].[0-255].[0-255]'.
    let ipAddressV4Check = #"^(25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)){3}$"#
    if hostname.range(of: ipAddressV4Check, options: .regularExpression) != nil {
        return true
    }

    // IPv6 regex: covers full, shorthand, and mixed notations.
    let ipAddressV6Check = #"^(([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){1,7}:)|(([0-9A-Fa-f]{1,4}:){1,6}:[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){1,5}(:[0-9A-Fa-f]{1,4}){1,2})|(([0-9A-Fa-f]{1,4}:){1,4}(:[0-9A-Fa-f]{1,4}){1,3})|(([0-9A-Fa-f]{1,4}:){1,3}(:[0-9A-Fa-f]{1,4}){1,4})|(([0-9A-Fa-f]{1,4}:){1,2}(:[0-9A-Fa-f]{1,4}){1,5})|([0-9A-Fa-f]{1,4}:((:[0-9A-Fa-f]{1,4}){1,6}))|(:((:[0-9A-Fa-f]{1,4}){1,7}|:))$"#
    if hostname.range(of: ipAddressV6Check, options: .regularExpression) != nil {
        return true
    }

    return false
}

/// An enumeration, representing loopback hosts.
public enum LoopbackHost: String, CaseIterable {

    ///
    case localhost = "localhost"

    ///
    case ipV4 = "127.0.0.1"

    ///
    case ipV6 = "[::1]"
}

/// Checks if a string is a recognized loopback host.
///
/// - Parameter host: The string to check.
/// - Returns: `true` if the string is a loopback host, or `false` if it's not.
public func isLoopbackHost(_ host: String) -> Bool {
    return LoopbackHost.allCases.contains { $0.rawValue == host }
}

/// Determines whether the host of the `URL` is a loopback host.
///
/// - Parameter input: The `URL` object to check.
/// - Returns: `true` if it's a loopback address, or `false` if not.
public func isLoopbackUrl(_ input: URL) -> Bool {
    guard let host = input.host else {
        return false
    }

    return isLoopbackHost(host)
}
