//
//  ContentView.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 05/10/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var newsReaderAPI: NewsReaderAPI = NewsReaderAPI.shared
    @State var articles: [Article] = []
    @State var articleImage: UIImage? = nil

    var body: some View {
        List(articles) { article in
            NavigationLink(destination: ArticleDetailView(article: article)) {
                ArticleCell(article: article)
            }
        }.navigationTitle("Newsreader")
        .onAppear {
            getArticles()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    getArticles()
                }) {
                    Text("Refresh")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                if (newsReaderAPI.isAuthenticated) {
                    Button(action: {
                        newsReaderAPI.logout()
                    }) {
                        Text("Logout")
                    }
                } else {
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                    }
                }
            }
        }
    }
    
    func getArticles() {
        NewsReaderAPI.shared.getArticles { (result) in
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
