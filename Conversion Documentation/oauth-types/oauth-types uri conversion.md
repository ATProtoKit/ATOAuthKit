# Conversion for `oauth-types/src/uri.ts`

## `const canParseUrl = URL.canParse ?? ((urlStr: string): boolean`

This has been converted.

Swift equivalent:

```swift
public static func canParseURL(_ url: String) -> Bool
```

## `export const dangerousUriSchema`

This has been converted.

Swift equivalent:

```swift
public struct DangerousURI: CustomStringConvertible
```

## `export const loopbackUriSchema`

This has been converted.

Swift equivalent:

```swift
public struct LoopbackRedirectURI
```

## `export const httpsUriSchema`

This has been converted.

```swift
public static func validateHTTPSURI(uriString: String) throws
```

It's now a function instead of a variable.

## `export const webUriSchema`

This has been converted.

```swift
public static func validateWebURI(uriString: String) throws
```

It's now a function instead of a variable.

## `export const privateUseUriSchema`

This has been converted.

```swift
public struct PrivateUseURI
```
