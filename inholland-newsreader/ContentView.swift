//
//  ContentView.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 05/10/2021.
//

import SwiftUI

struct ContentView: View {
    @State var articles: [Article] = []
    
    var body: some View {
        List(articles) { article in
            NavigationLink(destination: ArticleView(article: article)) {
                Text(article.title)
            }
        }.navigationTitle("Newsreader")
        .onAppear {
            ArticleAPI.shared.getArticles { (result) in
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
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    print("Button was tapped")
                }) {
                    HStack {
                        Image(systemName: "arrow.triangle.2.circlepath")
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: ProfileView()) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
