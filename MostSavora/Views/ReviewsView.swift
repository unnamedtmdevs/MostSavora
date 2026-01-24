//
//  ReviewsView.swift
//  MostSavora
//
//  Created by Simon Bakhanets on 24.01.2026.
//

import SwiftUI

struct ReviewsView: View {
    @EnvironmentObject var viewModel: ShoppingViewModel
    @State private var selectedFilter: ReviewFilter = .all
    
    enum ReviewFilter: String, CaseIterable {
        case all = "All Reviews"
        case products = "Products"
        case stores = "Stores"
        case verified = "Verified"
    }
    
    var filteredReviews: [Review] {
        switch selectedFilter {
        case .all:
            return viewModel.reviews
        case .products:
            return viewModel.reviews.filter { $0.productID != nil }
        case .stores:
            return viewModel.reviews.filter { $0.storeID != nil }
        case .verified:
            return viewModel.reviews.filter { $0.verifiedPurchase }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ColorTheme.secondaryBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Filter picker
                    Picker("Filter", selection: $selectedFilter) {
                        ForEach(ReviewFilter.allCases, id: \.self) { filter in
                            Text(filter.rawValue).tag(filter)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    // Reviews list
                    if filteredReviews.isEmpty {
                        Spacer()
                        VStack(spacing: 16) {
                            Image(systemName: "star.slash")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                            Text("No reviews yet")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(filteredReviews) { review in
                                    ReviewCard(review: review)
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("Community Reviews")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ReviewCard: View {
    let review: Review
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Text(review.authorName)
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        if review.verifiedPurchase {
                            HStack(spacing: 2) {
                                Image(systemName: "checkmark.seal.fill")
                                    .font(.caption)
                                Text("Verified")
                                    .font(.caption)
                            }
                            .foregroundColor(.blue)
                        }
                    }
                    
                    Text(review.formattedDate)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // Rating stars
                HStack(spacing: 2) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < Int(review.rating) ? "star.fill" : "star")
                            .font(.subheadline)
                            .foregroundColor(.yellow)
                    }
                }
            }
            
            // Title
            Text(review.title)
                .font(.subheadline)
                .fontWeight(.semibold)
            
            // Content
            Text(review.content)
                .font(.body)
                .foregroundColor(.secondary)
                .lineLimit(isExpanded ? nil : 3)
            
            if review.content.count > 100 {
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Text(isExpanded ? "Show less" : "Read more")
                        .font(.caption)
                        .foregroundColor(ColorTheme.accentOrange)
                }
            }
            
            // Footer
            HStack {
                Button(action: {}) {
                    HStack(spacing: 4) {
                        Image(systemName: "hand.thumbsup")
                            .font(.caption)
                        Text("\(review.helpfulCount)")
                            .font(.caption)
                    }
                    .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button(action: {}) {
                    HStack(spacing: 4) {
                        Image(systemName: "flag")
                            .font(.caption)
                        Text("Report")
                            .font(.caption)
                    }
                    .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .cardStyle()
    }
}

#Preview {
    ReviewsView()
        .environmentObject(ShoppingViewModel())
}
