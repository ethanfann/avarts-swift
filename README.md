# Avarts Widget

![Home Screen](https://i.imgur.com/faFC0Di.png)

![Widget](https://www.tangey.app/images/widget_light_s.png)

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

- GRAPHQL_URL: Ex. `https://example.com/graphql`
- CLIENT_URL: Ex. `https://example.com`
- ACCESS_GROUP Ex. `XXXX.com.ethanfann.Avarts`

4. Build and Run
