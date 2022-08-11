import Apollo
import SwiftUI

class Network {
    static let shared = Network()

    private(set) lazy var apollo: ApolloClient = {
        let client = URLSessionClient()
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let provider = NetworkInterceptorProvider(client: client, store: store)
        let url = ProcessInfo.processInfo.environment["GRAPHQL_URL"]!
        let transport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                     endpointURL: URL(string: url)!)
        return ApolloClient(networkTransport: transport, store: store)
    }()
}
