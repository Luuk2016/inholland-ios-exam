//
//  SignupResponse.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 23/10/2021.
//

import Foundation

struct SignupResponse: Decodable {
    let Success: Bool
    let Message: String
}
