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

## `export function isLoopbackUrl(input: URL | string): boolean`

This has been converted.

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

Swift has `JSONDecoder`, which will throw an error if the JSON object doesn't have the starting curly brace (`{`) or ending curly brace (`}`).

## `export const numberPreprocess = (val: unknown): unknown`

This is redundant and will not be converted.

`Int()` is able to convert a `String` object to an `Int`. If you need a number that's a decimal, then use `Double()` instead.
