# Conversion for `oauth-types/src/oauth-client-id-loopback.ts`

## `const PREFIX`

This has been converted.

```swift
public static let prefix
```

## `export const oauthClientIdLoopbackSchema`

This has been converted.

```swift
public struct ClientIDLoopback: CustomStringConvertible
```

This is now a `struct` that encapsulates everything in the file. The implementation is inside of the `struct`'s initializer:
```swift
public init(validating rawValue: String) throws
```

## `export function isOAuthClientIdLoopback(clientId: string,): clientId is OAuthClientIdLoopback`

This has been converted.

```swift
public static func isLoopbackClientID(_ clientID: String) -> Bool
```

## `export function assertOAuthLoopbackClientId(clientId: string,): asserts clientId is OAuthClientIdLoopback`

This is unneeded and will not be converted.

This is a TypeScript pattern that's unnecessary in Swift.

## `export function parseOAuthLoopbackClientId(clientId: string): {scope?: OAuthScope
  redirect_uris?: [OAuthRedirectUri, ...OAuthRedirectUri[]]
}`

This has been converted.

```swift
public static func parseOAuthLoopbackClientID(_ clientID: String) throws -> (scope: OAuthScope?, redirectURIs: [String]?)?
```
