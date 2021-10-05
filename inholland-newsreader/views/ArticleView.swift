//
//  ArticleView.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 05/10/2021.
//

import SwiftUI

struct ArticleView: View {
    let article: Article
    
    var body: some View {
        VStack {
            Image(systemName: article.image)
                .resizable()
                .scaledToFit()
            Text(article.title)
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            
            Text("Published on \(article.publishDate)")
                .foregroundColor(.secondary)
                        
            Text(article.summary)
                .padding(.horizontal)
                .padding(.vertical)
        }.navigationTitle("Article")
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: .testArticle)
    }
}
