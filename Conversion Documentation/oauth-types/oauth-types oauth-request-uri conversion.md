# Conversion for `oauth-types/src/oauth-request-uri.ts`

## `export const oauthRequestUriSchema`

This has been converted.

This has been turned into a `struct`. Trying to make it into a global variable has caused issues:
- Making it into a `let` variable gives little choice but to assign it (which would make the variable useless).
- Making it into a `var` variable gives little choice but to use `@MainActor`, which is not preferable.
