//
//  Product.swift
//  MostSavora
//
//  Created by Simon Bakhanets on 24.01.2026.
//

import Foundation

struct Product: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var description: String
    var category: ProductCategory
    var imageURL: String
    var prices: [StorePrice]
    var averageRating: Double
    var reviewCount: Int
    
    init(
        id: UUID = UUID(),
        name: String,
        description: String,
        category: ProductCategory,
        imageURL: String,
        prices: [StorePrice],
        averageRating: Double = 0.0,
        reviewCount: Int = 0
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.category = category
        self.imageURL = imageURL
        self.prices = prices
        self.averageRating = averageRating
        self.reviewCount = reviewCount
    }
    
    var lowestPrice: StorePrice? {
        prices.min(by: { $0.price < $1.price })
    }
    
    var highestPrice: StorePrice? {
        prices.max(by: { $0.price < $1.price })
    }
    
    var priceDifference: Double {
        guard let lowest = lowestPrice?.price,
              let highest = highestPrice?.price else { return 0 }
        return highest - lowest
    }
    
    var savingsPercentage: Double {
        guard let lowest = lowestPrice?.price,
              let highest = highestPrice?.price,
              highest > 0 else { return 0 }
        return ((highest - lowest) / highest) * 100
    }
}

struct StorePrice: Identifiable, Codable, Hashable {
    let id: UUID
    var storeName: String
    var storeID: UUID
    var price: Double
    var currency: String
    var inStock: Bool
    var lastUpdated: Date
    
    init(
        id: UUID = UUID(),
        storeName: String,
        storeID: UUID,
        price: Double,
        currency: String = "USD",
        inStock: Bool = true,
        lastUpdated: Date = Date()
    ) {
        self.id = id
        self.storeName = storeName
        self.storeID = storeID
        self.price = price
        self.currency = currency
        self.inStock = inStock
        self.lastUpdated = lastUpdated
    }
    
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        return formatter.string(from: NSNumber(value: price)) ?? "$\(price)"
    }
}

enum ProductCategory: String, Codable, CaseIterable {
    case electronics = "Electronics"
    case clothing = "Clothing"
    case food = "Food & Beverages"
    case home = "Home & Garden"
    case sports = "Sports & Outdoors"
    case beauty = "Beauty & Personal Care"
    case toys = "Toys & Games"
    case books = "Books"
    case automotive = "Automotive"
    case other = "Other"
    
    var iconName: String {
        switch self {
        case .electronics: return "laptopcomputer"
        case .clothing: return "tshirt"
        case .food: return "cart"
        case .home: return "house"
        case .sports: return "sportscourt"
        case .beauty: return "sparkles"
        case .toys: return "gamecontroller"
        case .books: return "book"
        case .automotive: return "car"
        case .other: return "tag"
        }
    }
}
