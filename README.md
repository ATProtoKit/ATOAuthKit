A (rough and work-in-progress) implementation of OAuth modified for the AT Protocol. This is based on the [oauth](https://github.com/bluesky-social/atproto/tree/main/packages/oauth) section of the official [`atproto`](https://github.com/bluesky-social/atproto) TypeScript repository.

This will remain at version 0.0.x until the following have been implemented:
- The main ATOAuthKit package (which will be the OAuth client) has been implemented.
- Unit tests for both ATOAuthKit and OAuthTypes have been implemented.
- A proper README has been added.

The project aims to target Swift 6.0 or later. This project will not be targeting Android, WebAssembly, or Windows for now, as the package needs to be thoroughly tested before it can be safely considered as compatible. Until then, this will target all Apple platforms and Linux.

> [!CAUTION]
> It’s strongly recommended that you don’t use the packages in this repository until it has been thoroughly tested and cleared by a security research team. Efforts to hire one will happen once The ATProtoKit Project gains significant funding. Until then, use this at your own risk.

This project is licenced under the Apache 2.0 licence. Please see LICENCE.md for more information.
