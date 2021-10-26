//
//  SignupRequest.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 23/10/2021.
//

import Foundation

struct SignupRequest: Encodable {
    let username: String
    let password: String
}
