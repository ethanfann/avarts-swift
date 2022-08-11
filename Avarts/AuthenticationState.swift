//
//  AuthenticationState.swift
//  Avarts
//
//  Created by Ethan Fann on 3/20/21.
//

import KeychainSwift
import Network
import SwiftUI

struct LatestActivity {
    var id: String
    var title: String
    var elevation: Int
    var distance: Int
}

struct User {
    var name: String
    var img: String
    var latestActivity: LatestActivity
    var measurementPreference: String
}

class AuthenticationState: NSObject, ObservableObject {
    @Published var loggedInUser: User?
    @Published var isAuthenticating = false
    @Published var error: NSError?

    static let shared = AuthenticationState()

    override init() {
        super.init()
        let keychain = KeychainSwift()
        let accessGroup = ProcessInfo.processInfo.environment["ACCESS_GROUP"]!
        keychain.accessGroup = accessGroup
        if keychain.get("token") != nil {
            loginFromToken()
        } else {
            logout()
        }
    }

    func login(email: String, password: String) {
        isAuthenticating = true
        error = nil

        handleSignIn(email: email, password: password)
    }

    func reload() {
        loginFromToken()
    }

    func logout() {
        let keychain = KeychainSwift()
        let accessGroup = ProcessInfo.processInfo.environment["ACCESS_GROUP"]!
        keychain.accessGroup = accessGroup
        keychain.clear()
        loggedInUser = nil
    }

    private func loginFromToken() {
        Network.shared.apollo.fetch(query: MeQuery(), cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let graphQLResult):
                if let me = graphQLResult.data?.me {
                    let latestActivity: LatestActivity = .init(id: me.latestActivity?.id ?? "0", title: me.latestActivity?.title ?? "", elevation: me.latestActivity?.elevation ?? 0, distance: me.latestActivity?.distance ?? 0)
                    let user: User = .init(name: me.name, img: me.img, latestActivity: latestActivity, measurementPreference: me.measurementPreference)
                    self.loggedInUser = user
                }
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }

    private func handleSignIn(email: String, password: String) {
        Network.shared.apollo.perform(mutation: LoginMutation(email: email, password: password)) { result in
            switch result {
            case .success(let graphQLResult):
                if let login = graphQLResult.data?.login {
                    let keychain = KeychainSwift()
                    keychain.set(login.token, forKey: "token")
                    let latestActivity: LatestActivity = .init(id: login.latestActivity?.id ?? "0", title: login.latestActivity?.title ?? "", elevation: login.latestActivity?.elevation ?? 0, distance: login.latestActivity?.distance ?? 0)
                    let user: User = .init(name: login.name, img: login.img, latestActivity: latestActivity, measurementPreference: login.measurementPreference)
                    self.loggedInUser = user
                }

            case .failure(let error):
                print(error)
            }
        }
    }
}
