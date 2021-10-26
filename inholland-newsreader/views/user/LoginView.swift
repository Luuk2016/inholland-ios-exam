//
//  LoginView.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 05/10/2021.
//

import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var isLoginErrorAlertPresented: Bool = false
    
    var isFormValid: Bool {
        return username.count >= 3 && password.count >= 3
    }
    
    var body: some View {
        VStack {
            Spacer()
                        
            TextField("Username", text: $username)
                .padding()
                .cornerRadius(5.0)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            SecureField("Password", text: $password)
                .padding()
                .cornerRadius(5.0)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                        
            Button("Login", action: {
                NewsReaderAPI.shared.login(username: self.username, password: self.password)
            }).disabled(isFormValid == false)
            
            Spacer()
            
            Text("Don't have an account yet?")
            
            NavigationLink(destination: SignupView()) {
                Text("Click here")
            }
        }.navigationTitle("Login")
        .alert(isPresented: $isLoginErrorAlertPresented) {
            Alert(title: Text("Error"), message: Text("Couldn't Login"), dismissButton: .default(Text("OK")))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
