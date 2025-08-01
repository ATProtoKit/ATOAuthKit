# Conversion for `oauth-types/src/util.ts`

## `export function isHostnameIP(hostname: string)`

This has been converted.

Swift equivalent:

```swift
public func isHostnameIPAddress(_ hostname: String) -> Bool
```

## `export type LoopbackHost`

This has been converted.

```swift
public enum LoopbackHost: String, CaseIterable
```

It's been converted into an `enum`.

## `export function isLoopbackHost(host: unknown): host is LoopbackHost`

This has been converted.

Swift equivalent:

```swift
public func isLoopbackHost(_ host: String) -> Bool
```

## `export function isLoopbackUrl(input: URL | string): boolean`

This has been converted.

Swift equivalent:

```swift
public func isLoopbackURL(_ input: URL) -> Bool
```

The method will only accept `URL` objects for safety reasons.

## `export function safeUrl(input: URL | string): URL | null

This is redundant and will not be converted.

In Swift, the `URL` object is already guaranteed to be a valid URL.

## `export function extractUrlPath(url)`

This is redundant and will not be converted.

You can instead use `.path(percentEncoded:)`:

```swift
let url = URL(string: "https://www.example.com/foo")
let urlPath = url?.path(percentEncoded: false)
```

If there's a situation where a host is needed, throw an error.

## `export const jsonObjectPreprocess = (val: unknown)`

This is unneeded and will not be converted.

When decoding JSON in Swift, you use `JSONDecoder`, which expects valid JSON data. If the string is not valid JSON (doesn't start/end with the left curly brace (`{`) and right curly brace (`}`)), decoding will fail with a clear error, so extra preprocessing is unnecessary.

## `export const numberPreprocess = (val: unknown): unknown`

This is redundant and will not be converted.

In Swift, convert a `String` object to an `Int` using `Int(string)` (or `Double(string)` for floating point), which returns `nil` if the conversion fails.

If your data source might have ambiguous types, handle type-checking and conversion explicitly using Swift’s type system and optionals.
