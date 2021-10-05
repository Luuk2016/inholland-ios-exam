//
//  ContentView.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 05/10/2021.
//

import SwiftUI

struct ContentView: View {
    
    let articles: [Article] = Article.testList
    
    var body: some View {
        List(articles) { article in
            NavigationLink(destination: ArticleView(article: article)) {
                ArticleCell(article: article)
            }
        }.navigationTitle("Newsreader")
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
