//
//  LoginView.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 05/10/2021.
//

import SwiftUI

struct SignupView: View {
    @State var username: String = ""
    @State var password: String = ""
    
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
            
            Button("Signup", action: {
                NewsReaderAPI.shared.signup(username: self.username, password: self.password)
            }).disabled(isFormValid == false)
            
            Spacer()
            
            Text("Already have an account?")
            
            NavigationLink(destination: LoginView()) {
                Text("Click here")
            }
        }.navigationTitle("Signup")
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
