//
//  Person.swift
//  FindACrew
//
//  Created by Ben Gohlke on 5/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Person: Codable {
    let name: String
    let birth_year: String
    let height: String
}

struct PersonSearch: Codable {
    let results: [Person]
}
