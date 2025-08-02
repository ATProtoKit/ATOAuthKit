# Conversion for `oauth-types/src/oauth-token-type.ts`

## `export const oauthTokenTypeSchema`

This has been converted.

Swift equivalent:

```swift
public enum OAuthTokenType: String, CaseIterable
```

Two methods have been created to the `enum`: `normalized` and `parse()`.

You should use `parse()` first, then use `normalized`.

```swift
if let tokenType = OAuthTokenType.parse("dpop") {
    print(tokenType.normalized) // "DPoP"
}
```
