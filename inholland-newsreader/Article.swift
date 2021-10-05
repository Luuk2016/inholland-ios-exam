//
//  Article.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 05/10/2021.
//

import Foundation

import Foundation

struct Article: Identifiable {
    let id: Int
    let name: String
    l
    
    var originalName: String {
        return "\(imageName)Original"
    }
    
    static let testPokemon: Pokemon = .init(id: 1, name: "bulbasaur", abilityCount: 3)
    
    static let testList: [Pokemon] = [
        .init(id: 1, name: "bulbasaur", abilityCount: 3),
        .init(id: 4, name: "charmander", abilityCount: 5),
        .init(id: 7, name: "squirtle", abilityCount: 3),
        .init(id: 203, name: "ditto", abilityCount: 0),
        .init(id: 132, name: "mewtwo", abilityCount: 10)
    ]
}

