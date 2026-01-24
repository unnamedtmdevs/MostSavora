//
//  WishlistItem.swift
//  MostSavora
//
//  Created by Simon Bakhanets on 24.01.2026.
//

import Foundation

struct WishlistItem: Identifiable, Codable, Hashable {
    let id: UUID
    var productID: UUID
    var productName: String
    var productImageURL: String
    var currentPrice: Double
    var targetPrice: Double?
    var priceAlertEnabled: Bool
    var notes: String
    var addedDate: Date
    var category: ProductCategory
    
    init(
        id: UUID = UUID(),
        productID: UUID,
        productName: String,
        productImageURL: String,
        currentPrice: Double,
        targetPrice: Double? = nil,
        priceAlertEnabled: Bool = false,
        notes: String = "",
        addedDate: Date = Date(),
        category: ProductCategory
    ) {
        self.id = id
        self.productID = productID
        self.productName = productName
        self.productImageURL = productImageURL
        self.currentPrice = currentPrice
        self.targetPrice = targetPrice
        self.priceAlertEnabled = priceAlertEnabled
        self.notes = notes
        self.addedDate = addedDate
        self.category = category
    }
    
    var isPriceAtTarget: Bool {
        guard let target = targetPrice else { return false }
        return currentPrice <= target
    }
    
    var formattedCurrentPrice: String {
        String(format: "$%.2f", currentPrice)
    }
    
    var formattedTargetPrice: String {
        guard let target = targetPrice else { return "Not set" }
        return String(format: "$%.2f", target)
    }
}

struct Wishlist: Identifiable, Codable {
    let id: UUID
    var name: String
    var items: [WishlistItem]
    var isShared: Bool
    var createdDate: Date
    
    init(
        id: UUID = UUID(),
        name: String,
        items: [WishlistItem] = [],
        isShared: Bool = false,
        createdDate: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.items = items
        self.isShared = isShared
        self.createdDate = createdDate
    }
    
    var totalValue: Double {
        items.reduce(0) { $0 + $1.currentPrice }
    }
}
