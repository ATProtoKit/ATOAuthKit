# Conversion for `oauth-types/src/oauth-redirect-uri.ts`

## `export const oauthLoopbackRedirectURISchema`

This has been converted.

Swift equivalent:

```swift
public struct OAuthLoopbackRedirectURI: Codable, CustomStringConvertible
```

## `export const oauthHttpsRedirectURISchema`

This is redundant and will not be converted.

This is simply a copy of `export const httpsUriSchema`. Use this directly if there are any references.

## `export const oauthPrivateUseRedirectURISchema`

This is redundant and will not be converted.

This is simply a copy of `export const privateUseUriSchema`. Use this directly if there are any references.

## `export const oauthRedirectUriSchema`

This has been converted.

```swift
public enum OAuthRedirectURI: Codable
```
