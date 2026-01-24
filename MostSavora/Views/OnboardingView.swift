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
            description: "Your smart shopping companion for finding the best deals and comparing prices across stores",
            imageName: "cart.fill",
            color: ColorTheme.accentOrange
        ),
        OnboardingPage(
            title: "Compare Prices",
            description: "See real-time price comparisons from multiple stores and find the best deals instantly",
            imageName: "chart.bar.fill",
            color: ColorTheme.primaryBackground
        ),
        OnboardingPage(
            title: "Smart Wishlists",
            description: "Create customizable wishlists and get notified when prices drop to your target",
            imageName: "heart.fill",
            color: ColorTheme.accentOrange
        ),
        OnboardingPage(
            title: "Community Reviews",
            description: "Read authentic reviews from other shoppers and make informed decisions",
            imageName: "star.fill",
            color: ColorTheme.primaryBackground
        ),
        OnboardingPage(
            title: "Never Miss a Deal",
            description: "Get instant notifications about exclusive deals and limited-time offers",
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
