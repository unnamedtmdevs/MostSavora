//
//  NetworkService.swift
//  MostSavora
//
//  Created by Simon Bakhanets on 24.01.2026.
//

import Foundation
import Combine

class NetworkService: ObservableObject {
    static let shared = NetworkService()
    
    private init() {}
    
    // MARK: - Mock Data Generation
    // In a real app, these would be API calls
    
    func fetchProducts() -> [Product] {
        let stores = fetchStores()
        
        return [
            Product(
                name: "Flagship Smartphone",
                description: "Premium smartphone with advanced camera system and long battery life",
                category: .electronics,
                imageURL: "iphone.circle.fill",
                prices: [
                    StorePrice(storeName: "TechHub Premium", storeID: stores[0].id, price: 999.00),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 979.00),
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 949.00)
                ],
                averageRating: 4.8,
                reviewCount: 1250
            ),
            Product(
                name: "Premium Smartphone",
                description: "High-performance smartphone with stunning display and powerful features",
                category: .electronics,
                imageURL: "smartphone",
                prices: [
                    StorePrice(storeName: "GadgetWorld", storeID: stores[3].id, price: 899.00),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 879.00),
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 849.00)
                ],
                averageRating: 4.7,
                reviewCount: 980
            ),
            Product(
                name: "Wireless Earbuds Pro",
                description: "True wireless earbuds with noise cancellation and premium sound quality",
                category: .electronics,
                imageURL: "airpodspro",
                prices: [
                    StorePrice(storeName: "TechHub Premium", storeID: stores[0].id, price: 249.00),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 249.00),
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 229.00)
                ],
                averageRating: 4.9,
                reviewCount: 3200
            ),
            Product(
                name: "Running Shoes",
                description: "Comfortable athletic shoes with cushioning technology for runners",
                category: .sports,
                imageURL: "figure.run",
                prices: [
                    StorePrice(storeName: "SportEdge", storeID: stores[4].id, price: 150.00),
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 139.99),
                    StorePrice(storeName: "AthleteZone", storeID: stores[5].id, price: 145.00)
                ],
                averageRating: 4.6,
                reviewCount: 560
            ),
            Product(
                name: "Noise-Canceling Headphones",
                description: "Over-ear headphones with active noise cancellation and premium audio",
                category: .electronics,
                imageURL: "headphones",
                prices: [
                    StorePrice(storeName: "AudioTech Store", storeID: stores[6].id, price: 399.00),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 379.00),
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 369.00)
                ],
                averageRating: 4.8,
                reviewCount: 2100
            ),
            Product(
                name: "Classic Denim Jeans",
                description: "Comfortable straight fit jeans made from quality denim fabric",
                category: .clothing,
                imageURL: "tshirt.fill",
                prices: [
                    StorePrice(storeName: "DenimCo", storeID: stores[7].id, price: 69.50),
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 59.99),
                    StorePrice(storeName: "MegaStore", storeID: stores[8].id, price: 64.99)
                ],
                averageRating: 4.5,
                reviewCount: 890
            ),
            Product(
                name: "Cordless Vacuum Cleaner",
                description: "Powerful cordless vacuum with advanced cleaning technology",
                category: .home,
                imageURL: "fanblades.fill",
                prices: [
                    StorePrice(storeName: "HomeAppliance Hub", storeID: stores[9].id, price: 649.99),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 629.99),
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 599.99)
                ],
                averageRating: 4.7,
                reviewCount: 1450
            ),
            Product(
                name: "Digital E-Reader",
                description: "Portable e-reader with high-resolution display for book lovers",
                category: .books,
                imageURL: "book.fill",
                prices: [
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 139.99),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 139.99),
                    StorePrice(storeName: "MegaStore", storeID: stores[8].id, price: 149.99)
                ],
                averageRating: 4.8,
                reviewCount: 5670
            ),
            Product(
                name: "Fitness Smartwatch",
                description: "Smartwatch with fitness tracking, heart rate monitoring, and GPS",
                category: .electronics,
                imageURL: "applewatch",
                prices: [
                    StorePrice(storeName: "TechHub Premium", storeID: stores[0].id, price: 399.00),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 389.00),
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 379.00)
                ],
                averageRating: 4.7,
                reviewCount: 2340
            ),
            Product(
                name: "Professional Laptop",
                description: "Lightweight laptop with powerful performance and all-day battery",
                category: .electronics,
                imageURL: "laptopcomputer",
                prices: [
                    StorePrice(storeName: "TechHub Premium", storeID: stores[0].id, price: 1199.00),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 1149.00),
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 1099.00)
                ],
                averageRating: 4.9,
                reviewCount: 4560
            ),
            Product(
                name: "Professional Tablet",
                description: "Large-screen tablet with high-resolution display for work and creativity",
                category: .electronics,
                imageURL: "ipad",
                prices: [
                    StorePrice(storeName: "TechHub Premium", storeID: stores[0].id, price: 1099.00),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 1079.00),
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 1049.00)
                ],
                averageRating: 4.8,
                reviewCount: 1890
            ),
            Product(
                name: "Handheld Gaming Device",
                description: "Portable gaming console with vibrant screen and enhanced audio",
                category: .toys,
                imageURL: "gamecontroller.fill",
                prices: [
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 349.99),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 349.99),
                    StorePrice(storeName: "MegaStore", storeID: stores[8].id, price: 349.99)
                ],
                averageRating: 4.9,
                reviewCount: 3450
            ),
            Product(
                name: "Gaming Console",
                description: "Home gaming console with high-definition graphics and fast performance",
                category: .toys,
                imageURL: "gamecontroller.fill",
                prices: [
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 499.99),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 499.99),
                    StorePrice(storeName: "MegaStore", storeID: stores[8].id, price: 499.99)
                ],
                averageRating: 4.8,
                reviewCount: 5670
            ),
            Product(
                name: "Performance Running Shoes",
                description: "High-quality running shoes with cushioning and support for athletes",
                category: .sports,
                imageURL: "figure.run",
                prices: [
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 189.99),
                    StorePrice(storeName: "AthleteZone", storeID: stores[5].id, price: 199.99),
                    StorePrice(storeName: "SportEdge", storeID: stores[4].id, price: 189.99)
                ],
                averageRating: 4.7,
                reviewCount: 890
            ),
            Product(
                name: "Digital Camera",
                description: "High-resolution camera with video recording capability",
                category: .electronics,
                imageURL: "camera.fill",
                prices: [
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 2499.00),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 2499.00)
                ],
                averageRating: 4.9,
                reviewCount: 780
            ),
            Product(
                name: "Wireless Headphones",
                description: "Comfortable over-ear headphones with long battery life",
                category: .electronics,
                imageURL: "headphones",
                prices: [
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 329.00),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 329.00)
                ],
                averageRating: 4.7,
                reviewCount: 2340
            ),
            Product(
                name: "Outdoor Winter Jacket",
                description: "Warm waterproof jacket with insulation for cold weather",
                category: .clothing,
                imageURL: "tshirt.fill",
                prices: [
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 299.00),
                    StorePrice(storeName: "MegaStore", storeID: stores[8].id, price: 299.00)
                ],
                averageRating: 4.6,
                reviewCount: 560
            ),
            Product(
                name: "Electric Pressure Cooker",
                description: "Multi-function electric cooker for quick meal preparation",
                category: .home,
                imageURL: "house.fill",
                prices: [
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 99.99),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 99.99),
                    StorePrice(storeName: "MegaStore", storeID: stores[8].id, price: 109.99)
                ],
                averageRating: 4.8,
                reviewCount: 12340
            ),
            Product(
                name: "Stand Mixer",
                description: "Powerful stand mixer perfect for baking and cooking",
                category: .home,
                imageURL: "house.fill",
                prices: [
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 379.99),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 399.99),
                    StorePrice(storeName: "MegaStore", storeID: stores[8].id, price: 379.99)
                ],
                averageRating: 4.9,
                reviewCount: 3450
            ),
            Product(
                name: "Fitness Tracker Band",
                description: "Wearable fitness tracker with heart rate and activity monitoring",
                category: .sports,
                imageURL: "figure.run",
                prices: [
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 159.99),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 159.99),
                    StorePrice(storeName: "MegaStore", storeID: stores[8].id, price: 159.99)
                ],
                averageRating: 4.5,
                reviewCount: 1890
            ),
            Product(
                name: "Large Screen Smart TV",
                description: "High-definition smart TV with streaming capabilities",
                category: .electronics,
                imageURL: "tv.fill",
                prices: [
                    StorePrice(storeName: "GadgetWorld", storeID: stores[3].id, price: 699.99),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 649.99),
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 629.99)
                ],
                averageRating: 4.6,
                reviewCount: 2340
            ),
            Product(
                name: "Single-Serve Coffee Maker",
                description: "Convenient coffee maker for single servings with quick brewing",
                category: .home,
                imageURL: "cup.and.saucer.fill",
                prices: [
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 179.99),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 189.99),
                    StorePrice(storeName: "MegaStore", storeID: stores[8].id, price: 179.99)
                ],
                averageRating: 4.7,
                reviewCount: 4560
            ),
            Product(
                name: "Wireless Computer Mouse",
                description: "Ergonomic wireless mouse with precision tracking",
                category: .electronics,
                imageURL: "computermouse.fill",
                prices: [
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 99.99),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 99.99)
                ],
                averageRating: 4.8,
                reviewCount: 890
            ),
            Product(
                name: "Stainless Steel Tumbler",
                description: "Insulated tumbler that keeps drinks at perfect temperature",
                category: .home,
                imageURL: "cup.and.saucer.fill",
                prices: [
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 34.99),
                    StorePrice(storeName: "MegaStore", storeID: stores[8].id, price: 34.99)
                ],
                averageRating: 4.9,
                reviewCount: 5670
            ),
            Product(
                name: "UV Protection Sunglasses",
                description: "Stylish sunglasses with UV protection for eye safety",
                category: .clothing,
                imageURL: "sunglasses.fill",
                prices: [
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 153.00),
                    StorePrice(storeName: "MegaStore", storeID: stores[8].id, price: 159.99)
                ],
                averageRating: 4.7,
                reviewCount: 3450
            ),
            Product(
                name: "Sports Water Bottle",
                description: "Insulated water bottle for athletes and outdoor activities",
                category: .sports,
                imageURL: "drop.fill",
                prices: [
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 44.95),
                    StorePrice(storeName: "MegaStore", storeID: stores[8].id, price: 44.95)
                ],
                averageRating: 4.8,
                reviewCount: 6780
            ),
            Product(
                name: "Robot Vacuum Cleaner",
                description: "Smart robot vacuum with automatic cleaning and navigation",
                category: .home,
                imageURL: "circle.grid.cross.fill",
                prices: [
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 799.99),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 799.99)
                ],
                averageRating: 4.5,
                reviewCount: 2340
            ),
            Product(
                name: "Portable Power Bank",
                description: "High-capacity portable charger for smartphones and devices",
                category: .electronics,
                imageURL: "battery.100.bolt",
                prices: [
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 49.99),
                    StorePrice(storeName: "ElectroMart", storeID: stores[1].id, price: 49.99)
                ],
                averageRating: 4.7,
                reviewCount: 8900
            ),
            Product(
                name: "Athletic Gym Bag",
                description: "Durable sports bag with compartments for gear and equipment",
                category: .sports,
                imageURL: "bag.fill",
                prices: [
                    StorePrice(storeName: "ShopZone", storeID: stores[2].id, price: 54.99),
                    StorePrice(storeName: "SportEdge", storeID: stores[4].id, price: 59.99)
                ],
                averageRating: 4.6,
                reviewCount: 1230
            )
        ]
    }
    
    func fetchStores() -> [Store] {
        return [
            Store(
                name: "TechHub Premium",
                description: "Premium electronics retailer offering the latest technology products and accessories",
                logoURL: "applelogo",
                website: "https://www.techhubpremium.com",
                averageRating: 4.7,
                reviewCount: 12500,
                categories: [.electronics]
            ),
            Store(
                name: "ElectroMart",
                description: "Leading electronics retailer with a wide selection of technology products",
                logoURL: "bolt.circle.fill",
                website: "https://www.electromart.com",
                averageRating: 4.4,
                reviewCount: 8900,
                categories: [.electronics, .home, .automotive]
            ),
            Store(
                name: "ShopZone",
                description: "Large online retailer offering millions of products across all categories",
                logoURL: "cart.fill",
                website: "https://www.shopzone.com",
                averageRating: 4.6,
                reviewCount: 50000,
                categories: ProductCategory.allCases
            ),
            Store(
                name: "GadgetWorld",
                description: "Modern electronics store specializing in smartphones, tablets, and smart home devices",
                logoURL: "smartphone",
                website: "https://www.gadgetworld.com",
                averageRating: 4.5,
                reviewCount: 3400,
                categories: [.electronics, .home]
            ),
            Store(
                name: "SportEdge",
                description: "Premium athletic store for sports footwear, apparel, and equipment",
                logoURL: "figure.run",
                website: "https://www.sportedge.com",
                averageRating: 4.6,
                reviewCount: 7800,
                categories: [.sports, .clothing]
            ),
            Store(
                name: "AthleteZone",
                description: "Athletic footwear and sportswear specialist",
                logoURL: "sportscourt.fill",
                website: "https://www.athletezone.com",
                averageRating: 4.3,
                reviewCount: 4500,
                categories: [.sports, .clothing]
            ),
            Store(
                name: "AudioTech Store",
                description: "Specialist in audio equipment, headphones, and entertainment electronics",
                logoURL: "headphones",
                website: "https://www.audiotech.com",
                averageRating: 4.5,
                reviewCount: 2900,
                categories: [.electronics]
            ),
            Store(
                name: "DenimCo",
                description: "Classic denim brand offering quality jeans and casual wear",
                logoURL: "tshirt.fill",
                website: "https://www.denimco.com",
                averageRating: 4.4,
                reviewCount: 3600,
                categories: [.clothing]
            ),
            Store(
                name: "MegaStore",
                description: "Major retail chain offering a wide variety of products for everyday life",
                logoURL: "target",
                website: "https://www.megastore.com",
                averageRating: 4.5,
                reviewCount: 15600,
                categories: ProductCategory.allCases
            ),
            Store(
                name: "HomeAppliance Hub",
                description: "Innovative home appliances and cleaning solutions",
                logoURL: "fanblades.fill",
                website: "https://www.homeappliancehub.com",
                averageRating: 4.6,
                reviewCount: 2100,
                categories: [.home]
            )
        ]
    }
    
    func fetchDeals() -> [Deal] {
        let products = fetchProducts()
        let calendar = Calendar.current
        
        return [
            Deal(
                title: "Smartphone Flash Sale",
                description: "Save big on flagship smartphone today only",
                productID: products[0].id,
                productName: products[0].name,
                storeID: products[0].prices[2].storeID,
                storeName: products[0].prices[2].storeName,
                originalPrice: 999.00,
                discountedPrice: 799.00,
                endDate: calendar.date(byAdding: .day, value: 7, to: Date())!,
                imageURL: products[0].imageURL,
                category: products[0].category
            ),
            Deal(
                title: "Audio Weekend Sale",
                description: "Limited time offer on premium headphones",
                productID: products[4].id,
                productName: products[4].name,
                storeID: products[4].prices[2].storeID,
                storeName: products[4].prices[2].storeName,
                originalPrice: 399.00,
                discountedPrice: 299.00,
                endDate: calendar.date(byAdding: .day, value: 2, to: Date())!,
                imageURL: products[4].imageURL,
                category: products[4].category
            ),
            Deal(
                title: "Athletic Footwear Sale",
                description: "Big savings on running shoes this week",
                productID: products[3].id,
                productName: products[3].name,
                storeID: products[3].prices[1].storeID,
                storeName: products[3].prices[1].storeName,
                originalPrice: 150.00,
                discountedPrice: 99.99,
                endDate: calendar.date(byAdding: .day, value: 14, to: Date())!,
                imageURL: products[3].imageURL,
                category: products[3].category
            ),
            Deal(
                title: "Wireless Earbuds Deal",
                description: "Special weekly discount on true wireless earbuds",
                productID: products[2].id,
                productName: products[2].name,
                storeID: products[2].prices[2].storeID,
                storeName: products[2].prices[2].storeName,
                originalPrice: 249.00,
                discountedPrice: 199.00,
                endDate: calendar.date(byAdding: .day, value: 1, to: Date())!,
                imageURL: products[2].imageURL,
                category: products[2].category
            ),
            Deal(
                title: "Home Cleaning Sale",
                description: "Cordless vacuum cleaner at special discounted price",
                productID: products[6].id,
                productName: products[6].name,
                storeID: products[6].prices[2].storeID,
                storeName: products[6].prices[2].storeName,
                originalPrice: 649.99,
                discountedPrice: 499.99,
                endDate: calendar.date(byAdding: .day, value: 10, to: Date())!,
                imageURL: products[6].imageURL,
                category: products[6].category
            )
        ]
    }
    
    func fetchReviews(for productID: UUID? = nil, storeID: UUID? = nil) -> [Review] {
        let allReviews = [
            Review(
                authorName: "Sarah M.",
                rating: 5.0,
                title: "Amazing product!",
                content: "This is exactly what I was looking for. The quality is outstanding and the price was great. Highly recommend!",
                date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
                helpfulCount: 45,
                verifiedPurchase: true
            ),
            Review(
                authorName: "John D.",
                rating: 4.0,
                title: "Good value for money",
                content: "Overall satisfied with the purchase. Works as described, though shipping took a bit longer than expected.",
                date: Calendar.current.date(byAdding: .day, value: -12, to: Date())!,
                helpfulCount: 28,
                verifiedPurchase: true
            ),
            Review(
                authorName: "Emily R.",
                rating: 5.0,
                title: "Best purchase this year",
                content: "Exceeded my expectations in every way. The build quality is excellent and it performs flawlessly. Worth every penny!",
                date: Calendar.current.date(byAdding: .day, value: -8, to: Date())!,
                helpfulCount: 67,
                verifiedPurchase: true
            ),
            Review(
                authorName: "Michael T.",
                rating: 3.0,
                title: "It's okay",
                content: "Does the job but nothing special. There are better options out there for a similar price.",
                date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
                helpfulCount: 12,
                verifiedPurchase: false
            ),
            Review(
                authorName: "Lisa K.",
                rating: 5.0,
                title: "Highly recommended!",
                content: "This product has changed my daily routine for the better. Easy to use and very reliable. Customer service was also excellent!",
                date: Calendar.current.date(byAdding: .day, value: -15, to: Date())!,
                helpfulCount: 89,
                verifiedPurchase: true
            ),
            Review(
                authorName: "David P.",
                rating: 5.0,
                title: "Perfect!",
                content: "Exactly as described. Fast shipping and excellent packaging. The product works perfectly and looks great!",
                date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
                helpfulCount: 34,
                verifiedPurchase: true
            ),
            Review(
                authorName: "Jennifer L.",
                rating: 4.0,
                title: "Great quality",
                content: "Really happy with this purchase. The build quality is solid and it does exactly what it's supposed to do.",
                date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!,
                helpfulCount: 23,
                verifiedPurchase: true
            ),
            Review(
                authorName: "Robert W.",
                rating: 5.0,
                title: "Excellent value",
                content: "For the price, this is an incredible product. I've been using it daily and couldn't be happier with my purchase.",
                date: Calendar.current.date(byAdding: .day, value: -18, to: Date())!,
                helpfulCount: 56,
                verifiedPurchase: true
            ),
            Review(
                authorName: "Amanda S.",
                rating: 4.0,
                title: "Very satisfied",
                content: "Good product overall. A few minor quirks but nothing that would stop me from recommending it.",
                date: Calendar.current.date(byAdding: .day, value: -10, to: Date())!,
                helpfulCount: 19,
                verifiedPurchase: true
            ),
            Review(
                authorName: "Chris B.",
                rating: 5.0,
                title: "Love it!",
                content: "This has become my go-to product. The quality is top-notch and it's incredibly easy to use. 10/10 would buy again!",
                date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!,
                helpfulCount: 78,
                verifiedPurchase: true
            ),
            Review(
                authorName: "Michelle H.",
                rating: 4.0,
                title: "Good purchase",
                content: "Happy with this buy. It does what it promises and the quality seems good. Time will tell how it holds up.",
                date: Calendar.current.date(byAdding: .day, value: -20, to: Date())!,
                helpfulCount: 15,
                verifiedPurchase: true
            ),
            Review(
                authorName: "Thomas G.",
                rating: 5.0,
                title: "Fantastic!",
                content: "Been using this for a few weeks now and it's been perfect. Great design, great functionality, great price!",
                date: Calendar.current.date(byAdding: .day, value: -14, to: Date())!,
                helpfulCount: 42,
                verifiedPurchase: true
            )
        ]
        
        // Filter based on productID or storeID if provided
        if let productID = productID {
            return allReviews.map { review in
                var updatedReview = review
                updatedReview.productID = productID
                return updatedReview
            }
        } else if let storeID = storeID {
            return allReviews.map { review in
                var updatedReview = review
                updatedReview.storeID = storeID
                return updatedReview
            }
        }
        
        return allReviews
    }
}
