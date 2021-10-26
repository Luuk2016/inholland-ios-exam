//
//  Article.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 05/10/2021.
//

import Foundation

struct Article: Decodable, Identifiable {
    let id = UUID()
    let identifier: Int
    let feed: Int
    let title: String
    let summary: String
    let publishDate: String
    let image: URL
    let url: String

    enum CodingKeys: String, CodingKey {
        case identifier = "Id"
        case feed = "Feed"
        case title = "Title"
        case summary = "Summary"
        case publishDate = "PublishDate"
        case image = "Image"
        case url = "Url"
    }
    
    static let testArticle: Article = .init(identifier: 1, feed: 1, title: "Lorem ipsum", summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", publishDate: "05-10-2021", image: URL(fileURLWithPath: String("https://google.com/")), url: "https://google.com/")
    
    static let testArticles: [Article] = [
        .init(identifier: 2, feed: 2, title: "Lorem ipsum", summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", publishDate: "05-10-2021", image: URL(fileURLWithPath: String("https://google.com/")), url: "https://google.com/"),
        .init(identifier: 3, feed: 3, title: "Lorem ipsum", summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", publishDate: "05-10-2021", image: URL(fileURLWithPath: String("https://google.com/")), url: "https://google.com/")
    ]
}
