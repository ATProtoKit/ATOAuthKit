# Conversion for `oauth-types/src/oauth-client-id-discoverable.ts`

## `export const oauthClientIdDiscoverableSchema`

This has been converted.

Swift equivalent:

```swift
public struct ClientIDDiscoverable: Codable
```

The original TypeScript checks to see if the string can be validated against `oauthClientIdSchema`. However, `oauthClientIdSchema`'s only validation is checking whether the string has at least one character inside it. For this reason, the Swift version will not validate against `OAuthClientID`. Instead, it will simply check if there's at least one character in the `rawValue`.

## `export function isOAuthClientIdDiscoverable(clientId: string,): clientId is OAuthClientIdDiscoverable`

This has been converted.

Swift equivalent:

```swift
public static func isDiscoverable(clientID: String) -> Bool
```

The function has been inserted into the `ClientIDDiscoverable` `struct` as a static method.

## `export const conventionalOAuthClientIdSchema`

This has been converted.

Swift equivalent:

```swift
public struct ConventionalOAuthClientID: Codable, CustomStringConvertible
```

## `export function isConventionalOAuthClientId(clientId: string,): clientId is ConventionalOAuthClientId`

This is redundant and will not be converted.

Swift's type safety will guarantee that the value provided is a `ConventionalOAuthClientID`.

The function has been inserted into the `ConventionalOAuthClientID` `struct` as a static method.

## `export function assertOAuthDiscoverableClientId(value: string,): asserts value is OAuthClientIdDiscoverable`

This is redundant and will not be converted.

This is effectively the same thing as `export function isOAuthClientIdDiscoverable(clientId: string,): clientId is OAuthClientIdDiscoverable`.

## `export function parseOAuthDiscoverableClientId(clientId: string): URL`

This is redundant and will not be converted.

This is effectively the same as creating a `URL` instance with the `ClientIDDiscoverable` `struct` as the argument value.
