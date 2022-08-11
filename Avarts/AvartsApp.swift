//
//  avarts_widgetApp.swift
//  avarts-widget
//
//  Created by Ethan Fann on 2/20/21.
//

import SwiftUI

@main
struct avarts_widgetApp: App {
    let authState = AuthenticationState.shared

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(authState)
        }
    }
}
