# Avarts Widget

Swift + SwiftUI companion app for [Avarts](https://github.com/ethanfann/avarts).

## Features

- Widget that syncs with latest uploaded activity

## Dependencies

- [Apollo](https://github.com/apollographql/apollo-ios)
- [Polyline](https://github.com/raphaelmor/Polyline)
- [KeychainSwift](https://github.com/evgenyneu/keychain-swift)

## Development

1. Host an instance of [Avarts](https://github.com/ethanfann/avarts)

2. [Setup a Keychain Access Group](https://developer.apple.com/documentation/security/keychain_services/keychain_items/sharing_access_to_keychain_items_among_a_collection_of_apps)

3. Fill in ENV variables

- GRAPHQL_URL
- CLIENT_URL
- ACCESS_GROUP

4. Build and Run
