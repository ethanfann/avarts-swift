//
//  TokenAddingInterceptor.swift
//  Avarts
//
//  Created by Ethan Fann on 2/23/21.
//

import Apollo
import KeychainSwift
import SwiftUI

class TokenAddingInterceptor: ApolloInterceptor {
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void)
    {
        if let accessGroup = ProcessInfo.processInfo.environment["ACCESS_GROUP"] {
            let keychain = KeychainSwift()
            keychain.accessGroup = accessGroup
            if let token = keychain.get("token") {
                request.addHeader(name: "Authorization", value: "Bearer \(token)")
            }

            chain.proceedAsync(request: request,
                               response: response,
                               completion: completion)
        }
    }
}
