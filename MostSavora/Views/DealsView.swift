//
//  DealsView.swift
//  MostSavora
//
//  Created by Simon Bakhanets on 24.01.2026.
//

import SwiftUI

struct DealsView: View {
    @EnvironmentObject var viewModel: ShoppingViewModel
    @State private var selectedCategory: ProductCategory?
    
    var filteredDeals: [Deal] {
        if let category = selectedCategory {
            return viewModel.getDeals(for: category)
        }
        return viewModel.activeDeals
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ColorTheme.secondaryBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Category filter
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            CategoryFilterButton(
                                title: "All Deals",
                                isSelected: selectedCategory == nil,
                                action: {
                                    selectedCategory = nil
                                }
                            )
                            
                            ForEach(ProductCategory.allCases, id: \.self) { category in
                                CategoryFilterButton(
                                    title: category.rawValue,
                                    isSelected: selectedCategory == category,
                                    action: {
                                        selectedCategory = category
                                    }
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 10)
                    
                    if filteredDeals.isEmpty {
                        Spacer()
                        VStack(spacing: 16) {
                            Image(systemName: "tag.slash")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                            Text("No active deals")
                                .font(.title2)
                                .foregroundColor(.gray)
                            Text("Check back soon for amazing offers!")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(filteredDeals) { deal in
                                    DealCard(deal: deal)
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("Deals")
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
    }
}

struct DealCard: View {
    let deal: Deal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Deal badge
            HStack {
                Text(deal.formattedDiscount)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(ColorTheme.accentOrange)
                    .cornerRadius(8)
                
                Spacer()
                
                if deal.daysRemaining > 0 {
                    HStack(spacing: 4) {
                        Image(systemName: "clock.fill")
                            .font(.caption)
                        Text("\(deal.daysRemaining) day\(deal.daysRemaining == 1 ? "" : "s") left")
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.red)
                }
            }
            .padding()
            .background(ColorTheme.primaryBackground.opacity(0.05))
            
            HStack(spacing: 16) {
                // Product image
                ProductImageView(imageName: deal.productName, size: 100)
                    .frame(width: 100, height: 100)
                
                VStack(alignment: .leading, spacing: 8) {
                    // Deal title
                    Text(deal.title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(ColorTheme.textOnLight)
                    
                    // Product name
                    Text(deal.productName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                    
                    // Store
                    HStack(spacing: 4) {
                        Image(systemName: "storefront.fill")
                            .font(.caption)
                        Text(deal.storeName)
                            .font(.caption)
                    }
                    .foregroundColor(.gray)
                    
                    // Prices
                    HStack(spacing: 8) {
                        Text(deal.formattedDiscountedPrice)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(ColorTheme.accentOrange)
                        
                        Text(deal.formattedOriginalPrice)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .strikethrough()
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .cardStyle()
    }
}

#Preview {
    DealsView()
        .environmentObject(ShoppingViewModel())
}
