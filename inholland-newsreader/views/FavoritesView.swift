//
//  FavoritesView.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 05/10/2021.
//

import SwiftUI

struct FavoritesView: View {

    var body: some View {
       VStack {
            Text("Please login or signup to save favorites")
                .font(.headline)
            NavigationLink(destination: ProfileView()) {
                Text("LOGIN / SIGNUP")
                    .font(.headline)
                    .padding()
                    .cornerRadius(15.0)
            }
        }.navigationTitle("Favorites")
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
