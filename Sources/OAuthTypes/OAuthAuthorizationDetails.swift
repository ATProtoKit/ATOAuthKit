//
//  OAuthAuthorizationDetails.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-30.
//

/// A structure representing the details of an authorization request for a specific resource or set
/// of resources.
public struct AuthorizationDetail: Codable {

    /// A string describing the type of resource being requested.
    public let type: String

    /// An array of locations of the resource. Optional.
    public let locations: [String]?

    /// An array of actions that can be done to the resource. Optional.
    public let actions: [String]?

    /// An array of data types the resource is requesting. Optional.
    public let dataTypes: [String]?

    /// A string identifier for a specific resource on an API. Optional.
    public let identifier: String?

    /// An array of strings that describe the types or levels of privilege being asked for at the resource.
    /// Optional.
    public let privileges: [String]?

    public init(type: String, locations: [String]?, actions: [String]?, dataTypes: [String]?, identifier: String?, privileges: [String]?) {
        self.type = type
        self.locations = locations
        self.actions = actions
        self.dataTypes = dataTypes
        self.identifier = identifier
        self.privileges = privileges
    }
}
