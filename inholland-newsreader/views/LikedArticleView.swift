//
//  LikedArticleView.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 24/10/2021.
//

import SwiftUI

struct LikedArticleView: View {
    @ObservedObject var newsReaderAPI: NewsReaderAPI = NewsReaderAPI.shared
    @Environment(\.openURL) var openURL
    let article: Article
    @State private var articleImage: UIImage? = nil
    
    var body: some View {
        ScrollView {
            if let articleImage = articleImage {
                Image(uiImage: articleImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            } else {
                ProgressView("Loading")
                    .onAppear {
                        NewsReaderAPI.shared.getImage(for: article) { result in
                            switch result {
                            case .success(let response):
                                self.articleImage = response
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
            
            Text(article.title)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            
            Text("Published on \(article.publishDate)")
                .foregroundColor(.secondary)
                        
            Text(article.summary)
                .padding(.horizontal)
                .padding(.vertical)
            
            Button("Open in browser", action: {
                openBrowser()
            })
        }.navigationTitle("Liked article")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    unlikeArticle(articleID: article.identifier)
                }) {
                    Text("Unlike article")
                }
            }
        }
    }
    
    func openBrowser() {
        guard let url = URL(string: article.url) else {
            return
        }
        openURL(url)
    }
    
    func unlikeArticle(articleID: Int) {
        newsReaderAPI.unlikeArticle(articleID: articleID)
    }
}

struct LikedArticleView_Previews: PreviewProvider {
    static var previews: some View {
        LikedArticleView(article: Article.testArticle)
    }
}
