//
//  FavoritesView.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 05/10/2021.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var newsReaderAPI: NewsReaderAPI = NewsReaderAPI.shared
    @State var articles: [Article] = []
    
    var body: some View {
       VStack {
           if (newsReaderAPI.isAuthenticated) {
               if (articles.count > 0) {
                   List(articles) { article in
                       NavigationLink(destination: LikedArticleView(article: article)) {
                           ArticleCell(article: article)
                       }
                   }.toolbar {
                       ToolbarItem(placement: .navigationBarLeading) {
                           Button(action: {
                               getFavoriteArticles()
                           }) {
                               Text("Refresh")
                           }
                       }
                   }
               } else {
                   Text("No liked articles have been found")
               }
           } else {
               Text("Please login or signup to save articles")
                   .font(.headline)
               
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
           }
        }.navigationTitle("Favorites")
        .onAppear {
            getFavoriteArticles()
        }
    }
    
    func getFavoriteArticles() {
        NewsReaderAPI.shared.getFavoriteArticles { (result) in
        switch result {
            case .success(let response):
                self.articles = response.articles
            case .failure(let error):
                switch error {
                case .urlError(let urlError):
                    print("URL Error: \(String(describing: urlError))")
                case .decodingError(let decodingError):
                    print("Decoding Error: \(String(describing: decodingError))")
                case .genericError(let error):
                    print("Error: \(String(describing: error))")
                }
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
//        users.remove(atOffsets: offsets)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
