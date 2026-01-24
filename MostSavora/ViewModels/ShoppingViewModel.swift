//
//  ShoppingViewModel.swift
//  MostSavora
//
//  Created by Simon Bakhanets on 24.01.2026.
//

import Foundation
import SwiftUI
import Combine

class ShoppingViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var stores: [Store] = []
    @Published var deals: [Deal] = []
    @Published var reviews: [Review] = []
    @Published var wishlists: [Wishlist] = []
    @Published var userSettings: UserSettings = .default
    
    @Published var searchText: String = ""
    @Published var selectedCategory: ProductCategory?
    @Published var isLoading: Bool = false
    
    private let networkService = NetworkService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadData()
        loadUserSettings()
        loadWishlists()
    }
    
    // MARK: - Data Loading
    
    func loadData() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            self.products = self.networkService.fetchProducts()
            self.stores = self.networkService.fetchStores()
            self.deals = self.networkService.fetchDeals()
            self.reviews = self.networkService.fetchReviews()
            
            self.isLoading = false
        }
    }
    
    func refreshData() {
        loadData()
    }
    
    // MARK: - Product Methods
    
    var filteredProducts: [Product] {
        var filtered = products
        
        // Filter by search text
        if !searchText.isEmpty {
            filtered = filtered.filter { product in
                product.name.localizedCaseInsensitiveContains(searchText) ||
                product.description.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Filter by category
        if let category = selectedCategory {
            filtered = filtered.filter { $0.category == category }
        }
        
        return filtered
    }
    
    func getProduct(by id: UUID) -> Product? {
        products.first { $0.id == id }
    }
    
    func getBestDeals() -> [Product] {
        products.filter { $0.savingsPercentage > 10 }
            .sorted { $0.savingsPercentage > $1.savingsPercentage }
    }
    
    // MARK: - Wishlist Methods
    
    func addToWishlist(product: Product) {
        guard let lowestPrice = product.lowestPrice else { return }
        
        let wishlistItem = WishlistItem(
            productID: product.id,
            productName: product.name,
            productImageURL: product.imageURL,
            currentPrice: lowestPrice.price,
            category: product.category
        )
        
        if wishlists.isEmpty {
            let defaultWishlist = Wishlist(name: "My Wishlist", items: [wishlistItem])
            wishlists.append(defaultWishlist)
        } else {
            wishlists[0].items.append(wishlistItem)
        }
        
        saveWishlists()
    }
    
    func removeFromWishlist(item: WishlistItem) {
        for index in wishlists.indices {
            wishlists[index].items.removeAll { $0.id == item.id }
        }
        saveWishlists()
    }
    
    func updateWishlistItem(_ item: WishlistItem) {
        for wishlistIndex in wishlists.indices {
            if let itemIndex = wishlists[wishlistIndex].items.firstIndex(where: { $0.id == item.id }) {
                wishlists[wishlistIndex].items[itemIndex] = item
            }
        }
        saveWishlists()
    }
    
    func isInWishlist(productID: UUID) -> Bool {
        wishlists.flatMap { $0.items }.contains { $0.productID == productID }
    }
    
    func createWishlist(name: String) {
        let newWishlist = Wishlist(name: name)
        wishlists.append(newWishlist)
        saveWishlists()
    }
    
    func deleteWishlist(_ wishlist: Wishlist) {
        wishlists.removeAll { $0.id == wishlist.id }
        saveWishlists()
    }
    
    // MARK: - Deal Methods
    
    var activeDeals: [Deal] {
        deals.filter { $0.isActive }
            .sorted { $0.discountPercentage > $1.discountPercentage }
    }
    
    func getDeals(for category: ProductCategory) -> [Deal] {
        activeDeals.filter { $0.category == category }
    }
    
    // MARK: - Review Methods
    
    func getReviews(forProduct productID: UUID) -> [Review] {
        networkService.fetchReviews(for: productID)
    }
    
    func getReviews(forStore storeID: UUID) -> [Review] {
        networkService.fetchReviews(for: nil, storeID: storeID)
    }
    
    func addReview(_ review: Review) {
        reviews.append(review)
    }
    
    // MARK: - Store Methods
    
    func getStore(by id: UUID) -> Store? {
        stores.first { $0.id == id }
    }
    
    // MARK: - Settings Methods
    
    func updateSettings(_ settings: UserSettings) {
        userSettings = settings
        saveUserSettings()
    }
    
    func resetApp() {
        // Clear all user data
        wishlists = []
        userSettings = .default
        
        saveWishlists()
        saveUserSettings()
        
        // Clear onboarding flag
        UserDefaults.standard.removeObject(forKey: "hasCompletedOnboarding")
    }
    
    // MARK: - Persistence
    
    private func loadWishlists() {
        if let data = UserDefaults.standard.data(forKey: "wishlists"),
           let decoded = try? JSONDecoder().decode([Wishlist].self, from: data) {
            wishlists = decoded
        }
    }
    
    private func saveWishlists() {
        if let encoded = try? JSONEncoder().encode(wishlists) {
            UserDefaults.standard.set(encoded, forKey: "wishlists")
        }
    }
    
    private func loadUserSettings() {
        if let data = UserDefaults.standard.data(forKey: "userSettings"),
           let decoded = try? JSONDecoder().decode(UserSettings.self, from: data) {
            userSettings = decoded
        }
    }
    
    private func saveUserSettings() {
        if let encoded = try? JSONEncoder().encode(userSettings) {
            UserDefaults.standard.set(encoded, forKey: "userSettings")
        }
    }
}
