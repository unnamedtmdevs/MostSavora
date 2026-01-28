//
//  ProductImageView.swift
//  MostSavora
//
//  Created by Simon Bakhanets on 24.01.2026.
//

import SwiftUI

struct ProductImageView: View {
    let imageName: String
    let size: CGFloat
    
    init(imageName: String, size: CGFloat = 100) {
        self.imageName = imageName
        self.size = size
    }
    
    var body: some View {
        ZStack {
            // Gradient background based on product type
            LinearGradient(
                gradient: gradientForProduct(imageName),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            // Product representation with better styling
            Image(systemName: iconForProduct(imageName))
                .font(.system(size: size * 0.5))
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
        }
        .cornerRadius(12)
    }
    
    private func gradientForProduct(_ name: String) -> Gradient {
        // Different gradients for different product categories
        let colors: [Color]
        
        switch name.lowercased() {
        case let s where s.contains("iphone") || s.contains("phone"):
            colors = [Color(hex: "667eea"), Color(hex: "764ba2")]
        case let s where s.contains("airpods") || s.contains("headphones"):
            colors = [Color(hex: "f093fb"), Color(hex: "f5576c")]
        case let s where s.contains("nike") || s.contains("shoes"):
            colors = [Color(hex: "4facfe"), Color(hex: "00f2fe")]
        case let s where s.contains("dyson") || s.contains("vacuum"):
            colors = [Color(hex: "43e97b"), Color(hex: "38f9d7")]
        case let s where s.contains("kindle") || s.contains("book"):
            colors = [Color(hex: "fa709a"), Color(hex: "fee140")]
        case let s where s.contains("jeans") || s.contains("clothing"):
            colors = [Color(hex: "30cfd0"), Color(hex: "330867")]
        case let s where s.contains("galaxy") || s.contains("samsung"):
            colors = [Color(hex: "a8edea"), Color(hex: "fed6e3")]
        case let s where s.contains("sony"):
            colors = [Color(hex: "ff9a9e"), Color(hex: "fecfef")]
        default:
            colors = [ColorTheme.primaryBackground, ColorTheme.accentOrange]
        }
        
        return Gradient(colors: colors)
    }
    
    private func iconForProduct(_ name: String) -> String {
        switch name.lowercased() {
        case let s where s.contains("iphone") || s.contains("phone"):
            return "iphone"
        case let s where s.contains("airpods"):
            return "airpodspro"
        case let s where s.contains("headphones") || s.contains("sony"):
            return "headphones"
        case let s where s.contains("nike") || s.contains("shoes"):
            return "figure.walk"
        case let s where s.contains("dyson") || s.contains("vacuum"):
            return "wind"
        case let s where s.contains("kindle") || s.contains("book"):
            return "book.fill"
        case let s where s.contains("jeans") || s.contains("clothing"):
            return "tshirt.fill"
        case let s where s.contains("galaxy") || s.contains("samsung"):
            return "smartphone"
        default:
            return "tag.fill"
        }
    }
}

// Product category gradient backgrounds
struct CategoryGradient {
    static func gradient(for category: ProductCategory) -> Gradient {
        let colors: [Color]
        
        switch category {
        case .electronics:
            colors = [Color(hex: "667eea"), Color(hex: "764ba2")]
        case .clothing:
            colors = [Color(hex: "30cfd0"), Color(hex: "330867")]
        case .food:
            colors = [Color(hex: "fddb92"), Color(hex: "d1fdff")]
        case .home:
            colors = [Color(hex: "89f7fe"), Color(hex: "66a6ff")]
        case .sports:
            colors = [Color(hex: "4facfe"), Color(hex: "00f2fe")]
        case .beauty:
            colors = [Color(hex: "fbc2eb"), Color(hex: "a6c1ee")]
        case .toys:
            colors = [Color(hex: "ffecd2"), Color(hex: "fcb69f")]
        case .books:
            colors = [Color(hex: "fa709a"), Color(hex: "fee140")]
        case .automotive:
            colors = [Color(hex: "a1c4fd"), Color(hex: "c2e9fb")]
        case .other:
            colors = [Color(hex: "fccb90"), Color(hex: "d57eeb")]
        }
        
        return Gradient(colors: colors)
    }
}

#Preview {
    VStack(spacing: 20) {
        ProductImageView(imageName: "iPhone 15 Pro", size: 150)
            .frame(width: 150, height: 150)
        
        ProductImageView(imageName: "AirPods Pro", size: 150)
            .frame(width: 150, height: 150)
        
        ProductImageView(imageName: "Nike Air Max", size: 150)
            .frame(width: 150, height: 150)
    }
    .padding()
}
