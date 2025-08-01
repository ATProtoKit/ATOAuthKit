# Conversion for `oauth-types/src/oauth-authorization-request-jar.ts`

## `export const oauthAuthorizationRequestJarSchema`

This has been converted.

Swift equivalent:

```swift
public struct AuthorizationRequestJAR
```

A number of declarations have been made in addition to this:
- A `protocol` named `JWTShapeValidating`, which validates the shape of a JSON Web Token. It includes a method named `isValidJWTShape(_ rawValue: String, expectedDotCount: Int)`, which validates the JWT shape, as well as the number of dots the string has.
- Two `struct`s named `SignedJWT` and `UnsignedJWT`, which conforms to `CustomStringConvertible` and `JWTShapeValidating`, validates the string to see that it's a signed or unsigned JWT respectively.
- An `enum` named `SessionToken
