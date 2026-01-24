//
//  Deal.swift
//  MostSavora
//
//  Created by Simon Bakhanets on 24.01.2026.
//

import Foundation

struct Deal: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var description: String
    var productID: UUID
    var productName: String
    var storeID: UUID
    var storeName: String
    var originalPrice: Double
    var discountedPrice: Double
    var discountPercentage: Double
    var startDate: Date
    var endDate: Date
    var imageURL: String
    var category: ProductCategory
    
    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        productID: UUID,
        productName: String,
        storeID: UUID,
        storeName: String,
        originalPrice: Double,
        discountedPrice: Double,
        startDate: Date = Date(),
        endDate: Date,
        imageURL: String,
        category: ProductCategory
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.productID = productID
        self.productName = productName
        self.storeID = storeID
        self.storeName = storeName
        self.originalPrice = originalPrice
        self.discountedPrice = discountedPrice
        self.discountPercentage = ((originalPrice - discountedPrice) / originalPrice) * 100
        self.startDate = startDate
        self.endDate = endDate
        self.imageURL = imageURL
        self.category = category
    }
    
    var isActive: Bool {
        let now = Date()
        return now >= startDate && now <= endDate
    }
    
    var formattedOriginalPrice: String {
        String(format: "$%.2f", originalPrice)
    }
    
    var formattedDiscountedPrice: String {
        String(format: "$%.2f", discountedPrice)
    }
    
    var formattedDiscount: String {
        String(format: "%.0f%% OFF", discountPercentage)
    }
    
    var daysRemaining: Int {
        Calendar.current.dateComponents([.day], from: Date(), to: endDate).day ?? 0
    }
}
