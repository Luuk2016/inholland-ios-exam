//
//  ProfileView.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 05/10/2021.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Hello!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
            
            Text("Please login or signup below")
                .font(.subheadline)
            
            NavigationLink(destination: LoginView()) {
                Text("LOGIN")
                    .font(.headline)
                    .padding()
                    .cornerRadius(15.0)
            }
            
            NavigationLink(destination: SignupView()) {
                Text("SIGNUP")
                    .font(.headline)
                    .padding()
                    .cornerRadius(15.0)
            }
            
        }.navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
