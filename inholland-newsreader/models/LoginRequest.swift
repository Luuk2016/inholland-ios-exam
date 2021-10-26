//
//  LoginRequest.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 23/10/2021.
//

import Foundation

struct LoginRequest: Encodable {
    let username: String
    let password: String
}
