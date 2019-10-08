//
//  UserSearchStructure.swift
//  DT
//
//  Created by Ivan Ermak on 9/26/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import Foundation

struct User {
    var similarity: Double
    var personaname: String
    var accountId: Int
    var avatarfull: URL
    var lastMatchTime: String?
}
