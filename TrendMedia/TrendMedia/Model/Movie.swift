//
//  Movie.swift
//  TrendMedia
//
//  Created by 박연배 on 2021/10/15.
//

import Foundation

struct Movie: Codable {
    var engTitle: String?
    var korTitle: String?
    var genre: String?
    var image: String?
    var rate: Double?
    var releaseDate: Date?
    var story: String?
    var country: String?
    var actors: [Actor]
}

struct Actor: Codable {
    var name: String?
    var image: String?
    var role: String?
}
