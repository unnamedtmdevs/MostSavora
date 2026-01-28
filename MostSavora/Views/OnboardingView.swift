//
//  OnboardingView.swift
//  MostSavora
//
//  Created by Simon Bakhanets on 24.01.2026.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var currentPage = 0
    
    let pages = [
        OnboardingPage(
            title: "Welcome to Most Savora",
            description: "Your ultimate shopping companion for finding the best deals and comparing prices across multiple stores in real-time",
            imageName: "cart.fill",
            color: ColorTheme.accentOrange
        ),
        OnboardingPage(
            title: "Compare Prices Instantly",
            description: "Browse thousands of products and compare prices from your favorite stores. Save money on every purchase with real-time price tracking",
            imageName: "chart.bar.fill",
            color: ColorTheme.primaryBackground
        ),
        OnboardingPage(
            title: "Smart Wishlists & Price Alerts",
            description: "Save products you love and set price alerts. We'll notify you instantly when your favorite items go on sale",
            imageName: "heart.fill",
            color: ColorTheme.accentOrange
        ),
        OnboardingPage(
            title: "Trusted Community Reviews",
            description: "Read verified reviews from real shoppers. Make informed purchasing decisions with ratings from our community of millions",
            imageName: "star.fill",
            color: ColorTheme.primaryBackground
        ),
        OnboardingPage(
            title: "Exclusive Deals & Offers",
            description: "Get personalized deal notifications based on your interests. Never miss out on flash sales and special promotions again",
            imageName: "bell.fill",
            color: ColorTheme.accentOrange
        )
    ]
    
    var body: some View {
        ZStack {
            ColorTheme.primaryBackground
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Page indicator
                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Circle()
                            .fill(currentPage == index ? ColorTheme.accentOrange : Color.white.opacity(0.5))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.top, 50)
                
                // Content
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        OnboardingPageView(page: pages[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // Buttons
                VStack(spacing: 16) {
                    if currentPage == pages.count - 1 {
                        Button(action: {
                            hasCompletedOnboarding = true
                        }) {
                            Text("Get Started")
                                .primaryButton()
                        }
                        .padding(.horizontal, 32)
                    } else {
                        HStack {
                            Button(action: {
                                hasCompletedOnboarding = true
                            }) {
                                Text("Skip")
                                    .font(.headline)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation {
                                    currentPage += 1
                                }
                            }) {
                                HStack {
                                    Text("Next")
                                        .font(.headline)
                                    Image(systemName: "arrow.right")
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 12)
                                .background(ColorTheme.accentOrange)
                                .cornerRadius(25)
                            }
                        }
                        .padding(.horizontal, 32)
                    }
                }
                .padding(.bottom, 50)
            }
        }
    }
}

struct OnboardingPage {
    let title: String
    let description: String
    let imageName: String
    let color: Color
}

struct OnboardingPageView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Icon
            ZStack {
                Circle()
                    .fill(page.color.opacity(0.2))
                    .frame(width: 200, height: 200)
                
                Image(systemName: page.imageName)
                    .font(.system(size: 80))
                    .foregroundColor(page.color)
            }
            
            // Title
            Text(page.title)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            
            // Description
            Text(page.description)
                .font(.system(size: 18))
                .foregroundColor(.white.opacity(0.9))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
        }
    }
}

#Preview {
    OnboardingView()
}
