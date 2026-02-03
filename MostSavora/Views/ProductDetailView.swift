//
//  ProductDetailView.swift
//  MostSavora
//
//  Created by Simon Bakhanets on 24.01.2026.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var viewModel: ShoppingViewModel
    @Environment(\.presentationMode) var presentationMode
    let product: Product
    
    @State private var selectedStore: StorePrice?
    @State private var showingAddToWishlist = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Product image
                    ProductImageView(imageName: product.name, size: 250)
                        .frame(height: 250)
                        .padding()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        // Product name
                        Text(product.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        // Rating
                        HStack {
                            HStack(spacing: 2) {
                                ForEach(0..<5) { index in
                                    Image(systemName: index < Int(product.averageRating) ? "star.fill" : "star")
                                        .font(.caption)
                                        .foregroundColor(.yellow)
                                }
                            }
                            Text(String(format: "%.1f", product.averageRating))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("(\(product.reviewCount) reviews)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        // Description
                        Text(product.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        // Category
                        HStack {
                            Image(systemName: product.category.iconName)
                            Text(product.category.rawValue)
                        }
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    // Price comparison
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Price Comparison")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        if let lowestPrice = product.lowestPrice,
                           let highestPrice = product.highestPrice {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Lowest Price")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(lowestPrice.formattedPrice)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(.green)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    Text("You Save")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(product.priceDifference.formatAsCurrency())
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(ColorTheme.accentOrange)
                                }
                            }
                            .padding()
                            .background(ColorTheme.primaryBackground.opacity(0.05))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }
                        
                        ForEach(product.prices.sorted(by: { $0.price < $1.price })) { storePrice in
                            StorePriceRow(storePrice: storePrice, isLowest: storePrice.id == product.lowestPrice?.id)
                                .onTapGesture {
                                    selectedStore = storePrice
                                }
                        }
                        .padding(.horizontal)
                    }
                    
                    Divider()
                        .padding(.horizontal)
                    
                    // Reviews section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Customer Reviews")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                            Text("See All")
                                .font(.subheadline)
                                .foregroundColor(ColorTheme.accentOrange)
                        }
                        .padding(.horizontal)
                        
                        ForEach(viewModel.getReviews(forProduct: product.id).prefix(3)) { review in
                            ReviewRow(review: review)
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.bottom, 100)
            }
            .background(ColorTheme.secondaryBackground)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if viewModel.isInWishlist(productID: product.id) {
                            // Already in wishlist
                        } else {
                            viewModel.addToWishlist(product: product)
                            showingAddToWishlist = true
                        }
                    }) {
                        Image(systemName: viewModel.isInWishlist(productID: product.id) ? "heart.fill" : "heart")
                            .foregroundColor(ColorTheme.accentOrange)
                    }
                }
            }
            .overlay(
                // Add to wishlist confirmation
                Group {
                    if showingAddToWishlist {
                        VStack {
                            Spacer()
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text("Added to Wishlist")
                                    .fontWeight(.semibold)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding(.bottom, 100)
                        }
                        .transition(.move(edge: .bottom))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showingAddToWishlist = false
                                }
                            }
                        }
                    }
                }
            )
        }
    }
}

struct StorePriceRow: View {
    let storePrice: StorePrice
    let isLowest: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(storePrice.storeName)
                    .font(.headline)
                Text(storePrice.inStock ? "In Stock" : "Out of Stock")
                    .font(.caption)
                    .foregroundColor(storePrice.inStock ? .green : .red)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(storePrice.formattedPrice)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(isLowest ? .green : ColorTheme.textOnLight)
                
                if isLowest {
                    Text("Best Price")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(ColorTheme.accentOrange)
                        .cornerRadius(4)
                }
            }
        }
        .padding()
        .cardStyle()
    }
}

struct ReviewRow: View {
    let review: Review
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(review.authorName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                HStack(spacing: 2) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < Int(review.rating) ? "star.fill" : "star")
                            .font(.caption)
                            .foregroundColor(.yellow)
                    }
                }
            }
            
            Text(review.title)
                .font(.subheadline)
                .fontWeight(.medium)
            
            Text(review.content)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(3)
            
            HStack {
                if review.verifiedPurchase {
                    HStack(spacing: 4) {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.caption)
                        Text("Verified Purchase")
                            .font(.caption)
                    }
                    .foregroundColor(.blue)
                }
                
                Spacer()
                
                Text(review.formattedDate)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .cardStyle()
    }
}

#Preview {
    ProductDetailView(product: Product(
        name: "Flagship Smartphone",
        description: "Premium smartphone with advanced features",
        category: .electronics,
        imageURL: "iphone.circle.fill",
        prices: [
            StorePrice(storeName: "TechHub Premium", storeID: UUID(), price: 999.00),
            StorePrice(storeName: "ShopZone", storeID: UUID(), price: 949.00)
        ],
        averageRating: 4.8,
        reviewCount: 1250
    ))
    .environmentObject(ShoppingViewModel())
}
