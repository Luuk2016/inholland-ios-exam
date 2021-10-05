//
//  Article.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 05/10/2021.
//

import Foundation

struct Article: Identifiable {
    public var id: Int
    public var title: String
    public var summary: String
    public var publishDate: String
    public var image: String
    public var url: String

    static let testArticle: Article = .init(id: 1, title: "Lorem ipsum", summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", publishDate: "05-10-2021", image: "face.smiling", url: "google.com")

    static let testList: [Article] = [
        .init(id: 2, title: "Lorem ipsum", summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", publishDate: "05-10-2021", image: "face.smiling", url: "google.com"),
        .init(id: 3, title: "Lorem ipsum", summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", publishDate: "05-10-2021", image: "face.smiling", url: "google.com"),
        .init(id: 4, title: "Lorem ipsum", summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", publishDate: "05-10-2021", image: "face.smiling", url: "google.com")
    ]
}
