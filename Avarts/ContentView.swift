//
//  ContentView.swift
//  avarts-widget
//
//  Created by Ethan Fann on 2/20/21.
//

import KeychainSwift
import Network
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State var authing: Bool = false
    @State var username: String = ""
    @State var password: String = ""

    var body: some View {
        Group {
            if authState.loggedInUser != nil {
                HomeView()
            } else {
                AuthenticationView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
