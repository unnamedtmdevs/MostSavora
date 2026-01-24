//
//  Review.swift
//  MostSavora
//
//  Created by Simon Bakhanets on 24.01.2026.
//

import Foundation

struct Review: Identifiable, Codable, Hashable {
    let id: UUID
    var authorName: String
    var rating: Double
    var title: String
    var content: String
    var date: Date
    var productID: UUID?
    var storeID: UUID?
    var helpfulCount: Int
    var verifiedPurchase: Bool
    
    init(
        id: UUID = UUID(),
        authorName: String,
        rating: Double,
        title: String,
        content: String,
        date: Date = Date(),
        productID: UUID? = nil,
        storeID: UUID? = nil,
        helpfulCount: Int = 0,
        verifiedPurchase: Bool = false
    ) {
        self.id = id
        self.authorName = authorName
        self.rating = rating
        self.title = title
        self.content = content
        self.date = date
        self.productID = productID
        self.storeID = storeID
        self.helpfulCount = helpfulCount
        self.verifiedPurchase = verifiedPurchase
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}
