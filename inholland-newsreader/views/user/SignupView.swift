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
                print("Signup was tapped!")
            })
            
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
