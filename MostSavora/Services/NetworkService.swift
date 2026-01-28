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
                name: "iPhone 15 Pro",
                description: "Latest Apple smartphone with A17 Pro chip, titanium design, and advanced camera system",
                category: .electronics,
                imageURL: "iphone.circle.fill",
                prices: [
                    StorePrice(storeName: "Apple Store", storeID: stores[0].id, price: 999.00),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 979.00),
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 949.00)
                ],
                averageRating: 4.8,
                reviewCount: 1250
            ),
            Product(
                name: "Samsung Galaxy S24",
                description: "Flagship Android phone with AI features, stunning display, and powerful performance",
                category: .electronics,
                imageURL: "smartphone",
                prices: [
                    StorePrice(storeName: "Samsung Store", storeID: stores[3].id, price: 899.00),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 879.00),
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 849.00)
                ],
                averageRating: 4.7,
                reviewCount: 980
            ),
            Product(
                name: "AirPods Pro (2nd Gen)",
                description: "Premium wireless earbuds with active noise cancellation and spatial audio",
                category: .electronics,
                imageURL: "airpodspro",
                prices: [
                    StorePrice(storeName: "Apple Store", storeID: stores[0].id, price: 249.00),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 249.00),
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 229.00)
                ],
                averageRating: 4.9,
                reviewCount: 3200
            ),
            Product(
                name: "Nike Air Max 270",
                description: "Comfortable running shoes with Max Air cushioning and breathable mesh",
                category: .sports,
                imageURL: "figure.run",
                prices: [
                    StorePrice(storeName: "Nike Store", storeID: stores[4].id, price: 150.00),
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 139.99),
                    StorePrice(storeName: "Foot Locker", storeID: stores[5].id, price: 145.00)
                ],
                averageRating: 4.6,
                reviewCount: 560
            ),
            Product(
                name: "Sony WH-1000XM5",
                description: "Industry-leading noise canceling headphones with exceptional sound quality",
                category: .electronics,
                imageURL: "headphones",
                prices: [
                    StorePrice(storeName: "Sony Store", storeID: stores[6].id, price: 399.00),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 379.00),
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 369.00)
                ],
                averageRating: 4.8,
                reviewCount: 2100
            ),
            Product(
                name: "Levi's 501 Original Jeans",
                description: "Classic straight fit jeans, the original since 1873",
                category: .clothing,
                imageURL: "tshirt.fill",
                prices: [
                    StorePrice(storeName: "Levi's Store", storeID: stores[7].id, price: 69.50),
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 59.99),
                    StorePrice(storeName: "Target", storeID: stores[8].id, price: 64.99)
                ],
                averageRating: 4.5,
                reviewCount: 890
            ),
            Product(
                name: "Dyson V15 Detect",
                description: "Advanced cordless vacuum with laser detection and powerful suction",
                category: .home,
                imageURL: "fanblades.fill",
                prices: [
                    StorePrice(storeName: "Dyson Store", storeID: stores[9].id, price: 649.99),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 629.99),
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 599.99)
                ],
                averageRating: 4.7,
                reviewCount: 1450
            ),
            Product(
                name: "Kindle Paperwhite",
                description: "Waterproof e-reader with high-resolution display and adjustable warm light",
                category: .books,
                imageURL: "book.fill",
                prices: [
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 139.99),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 139.99),
                    StorePrice(storeName: "Target", storeID: stores[8].id, price: 149.99)
                ],
                averageRating: 4.8,
                reviewCount: 5670
            ),
            Product(
                name: "Apple Watch Series 9",
                description: "Advanced fitness tracking with heart rate monitoring and GPS",
                category: .electronics,
                imageURL: "applewatch",
                prices: [
                    StorePrice(storeName: "Apple Store", storeID: stores[0].id, price: 399.00),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 389.00),
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 379.00)
                ],
                averageRating: 4.7,
                reviewCount: 2340
            ),
            Product(
                name: "MacBook Air M2",
                description: "Lightweight laptop with M2 chip, 13-inch display, and all-day battery",
                category: .electronics,
                imageURL: "laptopcomputer",
                prices: [
                    StorePrice(storeName: "Apple Store", storeID: stores[0].id, price: 1199.00),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 1149.00),
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 1099.00)
                ],
                averageRating: 4.9,
                reviewCount: 4560
            ),
            Product(
                name: "iPad Pro 12.9",
                description: "Professional tablet with M2 chip and Liquid Retina XDR display",
                category: .electronics,
                imageURL: "ipad",
                prices: [
                    StorePrice(storeName: "Apple Store", storeID: stores[0].id, price: 1099.00),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 1079.00),
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 1049.00)
                ],
                averageRating: 4.8,
                reviewCount: 1890
            ),
            Product(
                name: "Nintendo Switch OLED",
                description: "Gaming console with vibrant OLED screen and enhanced audio",
                category: .toys,
                imageURL: "gamecontroller.fill",
                prices: [
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 349.99),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 349.99),
                    StorePrice(storeName: "Target", storeID: stores[8].id, price: 349.99)
                ],
                averageRating: 4.9,
                reviewCount: 3450
            ),
            Product(
                name: "PlayStation 5",
                description: "Next-gen gaming console with 4K gaming and ultra-fast SSD",
                category: .toys,
                imageURL: "gamecontroller.fill",
                prices: [
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 499.99),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 499.99),
                    StorePrice(storeName: "Target", storeID: stores[8].id, price: 499.99)
                ],
                averageRating: 4.8,
                reviewCount: 5670
            ),
            Product(
                name: "Adidas Ultraboost 23",
                description: "Premium running shoes with responsive BOOST cushioning",
                category: .sports,
                imageURL: "figure.run",
                prices: [
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 189.99),
                    StorePrice(storeName: "Foot Locker", storeID: stores[5].id, price: 199.99),
                    StorePrice(storeName: "Nike Store", storeID: stores[4].id, price: 189.99)
                ],
                averageRating: 4.7,
                reviewCount: 890
            ),
            Product(
                name: "Canon EOS R6",
                description: "Full-frame mirrorless camera with 20MP sensor and 4K video",
                category: .electronics,
                imageURL: "camera.fill",
                prices: [
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 2499.00),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 2499.00)
                ],
                averageRating: 4.9,
                reviewCount: 780
            ),
            Product(
                name: "Bose QuietComfort 45",
                description: "Premium noise-cancelling headphones with 24-hour battery",
                category: .electronics,
                imageURL: "headphones",
                prices: [
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 329.00),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 329.00)
                ],
                averageRating: 4.7,
                reviewCount: 2340
            ),
            Product(
                name: "The North Face Jacket",
                description: "Waterproof outdoor jacket with insulation for cold weather",
                category: .clothing,
                imageURL: "tshirt.fill",
                prices: [
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 299.00),
                    StorePrice(storeName: "Target", storeID: stores[8].id, price: 299.00)
                ],
                averageRating: 4.6,
                reviewCount: 560
            ),
            Product(
                name: "Instant Pot Duo",
                description: "7-in-1 electric pressure cooker for fast and easy meals",
                category: .home,
                imageURL: "house.fill",
                prices: [
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 99.99),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 99.99),
                    StorePrice(storeName: "Target", storeID: stores[8].id, price: 109.99)
                ],
                averageRating: 4.8,
                reviewCount: 12340
            ),
            Product(
                name: "KitchenAid Stand Mixer",
                description: "Professional 5-quart mixer for baking and cooking",
                category: .home,
                imageURL: "house.fill",
                prices: [
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 379.99),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 399.99),
                    StorePrice(storeName: "Target", storeID: stores[8].id, price: 379.99)
                ],
                averageRating: 4.9,
                reviewCount: 3450
            ),
            Product(
                name: "Fitbit Charge 6",
                description: "Advanced fitness tracker with heart rate and GPS tracking",
                category: .sports,
                imageURL: "figure.run",
                prices: [
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 159.99),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 159.99),
                    StorePrice(storeName: "Target", storeID: stores[8].id, price: 159.99)
                ],
                averageRating: 4.5,
                reviewCount: 1890
            ),
            Product(
                name: "Samsung 55\" 4K TV",
                description: "Crystal UHD smart TV with HDR and built-in streaming apps",
                category: .electronics,
                imageURL: "tv.fill",
                prices: [
                    StorePrice(storeName: "Samsung Store", storeID: stores[3].id, price: 699.99),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 649.99),
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 629.99)
                ],
                averageRating: 4.6,
                reviewCount: 2340
            ),
            Product(
                name: "Nespresso Vertuo",
                description: "Single-serve coffee maker with barcode scanning technology",
                category: .home,
                imageURL: "cup.and.saucer.fill",
                prices: [
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 179.99),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 189.99),
                    StorePrice(storeName: "Target", storeID: stores[8].id, price: 179.99)
                ],
                averageRating: 4.7,
                reviewCount: 4560
            ),
            Product(
                name: "Logitech MX Master 3S",
                description: "Advanced wireless mouse with ergonomic design and precision tracking",
                category: .electronics,
                imageURL: "computermouse.fill",
                prices: [
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 99.99),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 99.99)
                ],
                averageRating: 4.8,
                reviewCount: 890
            ),
            Product(
                name: "Yeti Rambler Tumbler",
                description: "Insulated stainless steel tumbler that keeps drinks cold for hours",
                category: .home,
                imageURL: "cup.and.saucer.fill",
                prices: [
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 34.99),
                    StorePrice(storeName: "Target", storeID: stores[8].id, price: 34.99)
                ],
                averageRating: 4.9,
                reviewCount: 5670
            ),
            Product(
                name: "Ray-Ban Wayfarer Sunglasses",
                description: "Classic sunglasses with UV protection and timeless style",
                category: .clothing,
                imageURL: "sunglasses.fill",
                prices: [
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 153.00),
                    StorePrice(storeName: "Target", storeID: stores[8].id, price: 159.99)
                ],
                averageRating: 4.7,
                reviewCount: 3450
            ),
            Product(
                name: "Hydro Flask Water Bottle",
                description: "Insulated water bottle that keeps drinks cold for 24 hours",
                category: .sports,
                imageURL: "drop.fill",
                prices: [
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 44.95),
                    StorePrice(storeName: "Target", storeID: stores[8].id, price: 44.95)
                ],
                averageRating: 4.8,
                reviewCount: 6780
            ),
            Product(
                name: "Roomba j7+",
                description: "Self-emptying robot vacuum with obstacle avoidance",
                category: .home,
                imageURL: "circle.grid.cross.fill",
                prices: [
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 799.99),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 799.99)
                ],
                averageRating: 4.5,
                reviewCount: 2340
            ),
            Product(
                name: "Anker PowerCore 20000",
                description: "High-capacity portable charger with fast charging",
                category: .electronics,
                imageURL: "battery.100.bolt",
                prices: [
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 49.99),
                    StorePrice(storeName: "Best Buy", storeID: stores[1].id, price: 49.99)
                ],
                averageRating: 4.7,
                reviewCount: 8900
            ),
            Product(
                name: "Under Armour Sports Bag",
                description: "Durable gym bag with multiple compartments and water-resistant fabric",
                category: .sports,
                imageURL: "bag.fill",
                prices: [
                    StorePrice(storeName: "Amazon", storeID: stores[2].id, price: 54.99),
                    StorePrice(storeName: "Nike Store", storeID: stores[4].id, price: 59.99)
                ],
                averageRating: 4.6,
                reviewCount: 1230
            )
        ]
    }
    
    func fetchStores() -> [Store] {
        return [
            Store(
                name: "Apple Store",
                description: "Official Apple retail store offering the latest Apple products and accessories",
                logoURL: "applelogo",
                website: "https://www.apple.com",
                averageRating: 4.7,
                reviewCount: 12500,
                categories: [.electronics]
            ),
            Store(
                name: "Best Buy",
                description: "Leading electronics retailer with a wide selection of technology products",
                logoURL: "bolt.circle.fill",
                website: "https://www.bestbuy.com",
                averageRating: 4.4,
                reviewCount: 8900,
                categories: [.electronics, .home, .automotive]
            ),
            Store(
                name: "Amazon",
                description: "World's largest online retailer offering millions of products",
                logoURL: "cart.fill",
                website: "https://www.amazon.com",
                averageRating: 4.6,
                reviewCount: 50000,
                categories: ProductCategory.allCases
            ),
            Store(
                name: "Samsung Store",
                description: "Official Samsung retail store for smartphones, tablets, and home electronics",
                logoURL: "smartphone",
                website: "https://www.samsung.com",
                averageRating: 4.5,
                reviewCount: 3400,
                categories: [.electronics, .home]
            ),
            Store(
                name: "Nike Store",
                description: "Official Nike store for athletic footwear, apparel, and equipment",
                logoURL: "figure.run",
                website: "https://www.nike.com",
                averageRating: 4.6,
                reviewCount: 7800,
                categories: [.sports, .clothing]
            ),
            Store(
                name: "Foot Locker",
                description: "Premium athletic footwear and apparel retailer",
                logoURL: "sportscourt.fill",
                website: "https://www.footlocker.com",
                averageRating: 4.3,
                reviewCount: 4500,
                categories: [.sports, .clothing]
            ),
            Store(
                name: "Sony Store",
                description: "Official Sony retail store for electronics and entertainment products",
                logoURL: "headphones",
                website: "https://www.sony.com",
                averageRating: 4.5,
                reviewCount: 2900,
                categories: [.electronics]
            ),
            Store(
                name: "Levi's Store",
                description: "Iconic American denim brand offering jeans and casual wear",
                logoURL: "tshirt.fill",
                website: "https://www.levi.com",
                averageRating: 4.4,
                reviewCount: 3600,
                categories: [.clothing]
            ),
            Store(
                name: "Target",
                description: "Major retail chain offering a wide variety of products",
                logoURL: "target",
                website: "https://www.target.com",
                averageRating: 4.5,
                reviewCount: 15600,
                categories: ProductCategory.allCases
            ),
            Store(
                name: "Dyson Store",
                description: "Official Dyson store for innovative home appliances",
                logoURL: "fanblades.fill",
                website: "https://www.dyson.com",
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
                title: "Black Friday Special",
                description: "Huge discount on flagship smartphone",
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
                title: "Weekend Flash Sale",
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
                title: "Spring Clearance",
                description: "Save big on athletic footwear",
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
                title: "Tech Tuesday",
                description: "Weekly tech deal on wireless earbuds",
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
                title: "Home Improvement Sale",
                description: "Premium vacuum cleaner at special price",
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
