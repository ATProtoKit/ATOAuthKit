//
//  OpenIDClaimsProperties.swift
//  ATOAuthKit
//
//  Created by Christopher Jr Riley on 2025-07-26.
//

/// Represents the properties associated with an OpenID Connect claim.
///
/// Use this struct to define additional requirements or constraints for a specific claim,
/// such as whether the claim is essential, or acceptable value(s) for the claim.
public struct OpenIDConnectClaimsProperties: Codable {

    /// Determines whether the claim is essential or not.
    public let isEssential: Bool?

    /// A specific value that the claim must match. Optional.
    ///
    /// Use this property to specify that only a particular value of the claim is acceptable.
    public let value: String?

    /// An array of values that the claim must match. Optional.
    ///
    /// Use this property to allow any one of the provided values for the claim to be
    /// considered valid.
    public let values: [OpenIDConnectClaimsValue]?

    enum CodingKeys: String, CodingKey {
        case isEssential = "essential"
        case value
        case values
    }
}

/// Represents a possible value type for an OpenID Connect claim.
///
/// This enum models the potential types an OpenID Connect claim value can take.
/// The value may be a string, a number (floating-point), or a boolean.
/// Used for claims that allow multiple possible values or types.
public enum OpenIDConnectClaimsValue: Codable {

    /// A "string" value.
    case string(String)

    /// A "number" value.
    ///
    /// This will be a `Double`, since the number can be a decimal. Convert between `Int` and
    /// `Double` as needed.
    case number(Double)

    /// A "boolean" value.
    case boolean(Bool)

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode(Double.self) {
            self = .number(value)
        } else if let value = try? container.decode(Bool.self) {
            self = .boolean(value)
        } else {
            throw DecodingError.typeMismatch(
                OpenIDConnectClaimsValue.self, DecodingError.Context(
                    codingPath: decoder.codingPath, debugDescription: "Unknown OpenIDConnectClaimsValue type"))
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
            case .string(let value):
                try container.encode(value)
            case .number(let value):
                try container.encode(value)
            case .boolean(let value):
                try container.encode(value)
        }
    }

    enum CodingKeys: CodingKey {
        case string
        case number
        case boolean
    }
}
