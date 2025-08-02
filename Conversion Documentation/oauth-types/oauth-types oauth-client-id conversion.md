# Conversion for `oauth-types/src/oauth-client-id.ts`

## `export const oauthClientIdSchema`

This is redundant and will not be converted.

This is a Zod-specific pattern.

## `export type OAuthClientId`

This has been converted.

Swift equivalent:

```swift
public struct OAuthClientID: Codable, CustomStringConvertible
```

It's been renamed to `OAuthClientID`, conforming to `ExpressibleByStringLiteral`. It acts like a `String` to an extent, with the added ability of checking if the string contains one character. If it has multiple characters, it will take the first character and throw the rest of them away.
