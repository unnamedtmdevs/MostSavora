//
//  Store.swift
//  MostSavora
//
//  Created by Simon Bakhanets on 24.01.2026.
//

import Foundation

struct Store: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var description: String
    var logoURL: String
    var website: String
    var averageRating: Double
    var reviewCount: Int
    var categories: [ProductCategory]
    
    init(
        id: UUID = UUID(),
        name: String,
        description: String,
        logoURL: String,
        website: String,
        averageRating: Double = 0.0,
        reviewCount: Int = 0,
        categories: [ProductCategory] = []
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.logoURL = logoURL
        self.website = website
        self.averageRating = averageRating
        self.reviewCount = reviewCount
        self.categories = categories
    }
}
