//
//  ArticleCell.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 05/10/2021.
//

import SwiftUI

struct ArticleCell: View {
    let article: Article
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(article.title.capitalized)
                    .font(.title2)
                Text(article.publishDate.capitalized)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct ArticleCell_Previews: PreviewProvider {
    static var previews: some View {
        ArticleCell(article: .testArticle)
    }
}
