//
//  MainView.swift
//  MostSavora
//
//  Created by Simon Bakhanets on 24.01.2026.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ShoppingViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PriceComparisonView()
                .environmentObject(viewModel)
                .tabItem {
                    Label("Shop", systemImage: "cart.fill")
                }
                .tag(0)
            
            WishlistView()
                .environmentObject(viewModel)
                .tabItem {
                    Label("Wishlist", systemImage: "heart.fill")
                }
                .tag(1)
            
            DealsView()
                .environmentObject(viewModel)
                .tabItem {
                    Label("Deals", systemImage: "tag.fill")
                }
                .tag(2)
            
            ReviewsView()
                .environmentObject(viewModel)
                .tabItem {
                    Label("Reviews", systemImage: "star.fill")
                }
                .tag(3)
            
            SettingsView()
                .environmentObject(viewModel)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(4)
        }
        .accentColor(ColorTheme.accentOrange)
    }
}

#Preview {
    MainView()
}
