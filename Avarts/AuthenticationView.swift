//
//  AuthenticationView.swift
//  Avarts
//
//  Created by Ethan Fann on 3/20/21.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct AuthenticationView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State var authing: Bool = false
    @State var username: String = ""
    @State var password: String = ""

    var buttonDisabled: Bool {
        return authing || username.isEmpty || password.isEmpty
    }

    var buttonColor: Color {
        return buttonDisabled ? .gray : .accentColor
    }

    var buttonText: String {
        return authing ? "LOGGING IN..." : "LOGIN"
    }

    var body: some View {
        VStack {
            Text("Avarts")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            TextField("Username", text: $username)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(10)
                .padding()
                .disableAutocorrection(true)
                .autocapitalization(.none)
            SecureField("Password", text: $password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(10)
                .padding()
                .disableAutocorrection(true)
                .autocapitalization(.none)
            Button(action: {
                self.authing = true
                authState.login(email: username, password: password)
                self.authing = false
            }) {
                Text(buttonText)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(buttonColor)
                    .cornerRadius(15.0)
            }
            .padding()
            .disabled(buttonDisabled)
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
