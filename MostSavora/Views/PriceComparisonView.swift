//
//  PriceComparisonView.swift
//  MostSavora
//
//  Created by Simon Bakhanets on 24.01.2026.
//

import SwiftUI

struct PriceComparisonView: View {
    @EnvironmentObject var viewModel: ShoppingViewModel
    @State private var showingProductDetail: Product?
    
    var body: some View {
        NavigationView {
            ZStack {
                ColorTheme.secondaryBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search products...", text: $viewModel.searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        if !viewModel.searchText.isEmpty {
                            Button(action: {
                                viewModel.searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    .padding()
                    
                    // Category filter
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            CategoryFilterButton(
                                title: "All",
                                isSelected: viewModel.selectedCategory == nil,
                                action: {
                                    viewModel.selectedCategory = nil
                                }
                            )
                            
                            ForEach(ProductCategory.allCases, id: \.self) { category in
                                CategoryFilterButton(
                                    title: category.rawValue,
                                    isSelected: viewModel.selectedCategory == category,
                                    action: {
                                        viewModel.selectedCategory = category
                                    }
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 10)
                    
                    // Products grid
                    if viewModel.isLoading {
                        Spacer()
                        ProgressView()
                            .scaleEffect(1.5)
                        Spacer()
                    } else if viewModel.filteredProducts.isEmpty {
                        Spacer()
                        VStack(spacing: 16) {
                            Image(systemName: "cart.badge.questionmark")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                            Text("No products found")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 16) {
                                ForEach(viewModel.filteredProducts) { product in
                                    ProductCard(product: product)
                                        .onTapGesture {
                                            showingProductDetail = product
                                        }
                                }
                            }
                            .padding()
                        }
                    }
                }
                .navigationTitle("Shop")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewModel.refreshData()
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(ColorTheme.accentOrange)
                        }
                    }
                }
            }
            .sheet(item: $showingProductDetail) { product in
                ProductDetailView(product: product)
                    .environmentObject(viewModel)
            }
        }
    }
}

struct CategoryFilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? ColorTheme.accentOrange : Color.white)
                .foregroundColor(isSelected ? .white : ColorTheme.textOnLight)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 1)
        }
    }
}

struct ProductCard: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Product image
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(ColorTheme.primaryBackground.opacity(0.1))
                    .frame(height: 140)
                
                Image(systemName: product.imageURL)
                    .font(.system(size: 50))
                    .foregroundColor(ColorTheme.primaryBackground)
            }
            
            // Product name
            Text(product.name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(ColorTheme.textOnLight)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
            // Rating
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .font(.caption)
                    .foregroundColor(.yellow)
                Text(String(format: "%.1f", product.averageRating))
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("(\(product.reviewCount))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            // Price info
            if let lowestPrice = product.lowestPrice {
                VStack(alignment: .leading, spacing: 2) {
                    Text(lowestPrice.formattedPrice)
                        .font(.headline)
                        .foregroundColor(ColorTheme.accentOrange)
                    
                    if product.savingsPercentage > 0 {
                        Text("Save \(Int(product.savingsPercentage))%")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                }
            }
        }
        .padding(12)
        .cardStyle()
    }
}

#Preview {
    PriceComparisonView()
        .environmentObject(ShoppingViewModel())
}
