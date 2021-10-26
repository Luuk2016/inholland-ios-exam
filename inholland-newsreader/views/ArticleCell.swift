//
//  ArticleCell.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 21/10/2021.
//

import Foundation
import SwiftUI

struct ArticleCell: View {
    let article: Article
    @State private var articleImage: UIImage? = nil

    var body: some View {
        HStack {
            if let articleImage = articleImage {
                Image(uiImage: articleImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
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
        }
    }
}

struct ArticleCell_Previews: PreviewProvider {
    static var previews: some View {
        ArticleCell(article: Article.testArticle)
    }
}

