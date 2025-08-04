# Conversion for `oauth-types/src/oauth-introspection-response.ts`

## `export type OAuthIntrospectionResponse`

This has been converted.

Swift equivalent:

```swift
public enum OAuthIntrospectionResponse: Codable
```

The original TypeScript uses a discriminated union for this. For the Swift implementation, a `struct` named `OAuthIntrospectionResponseDetails` is created within the `OAuthIntrospectionResponse` `enum`. 

Marking the `enum` as `active` will allow for decoding the JSON object into the `OAuthIntrospectionResponse.OAuthIntrospectionResponseDetails` `struct`.
