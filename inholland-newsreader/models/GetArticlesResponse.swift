//
//  GetArticlesResponse.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 11/10/2021.
//

import Foundation

struct GetArticlesResponse: Decodable {
    let articles: [Article]

    enum CodingKeys: String, CodingKey {
        case articles = "Results"
    }
}
