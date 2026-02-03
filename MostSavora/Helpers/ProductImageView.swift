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
        case let s where s.contains("smartphone") || s.contains("phone"):
            colors = [Color(hex: "667eea"), Color(hex: "764ba2")]
        case let s where s.contains("earbuds") || s.contains("headphones"):
            colors = [Color(hex: "f093fb"), Color(hex: "f5576c")]
        case let s where s.contains("shoes") || s.contains("running"):
            colors = [Color(hex: "4facfe"), Color(hex: "00f2fe")]
        case let s where s.contains("vacuum") || s.contains("cleaner"):
            colors = [Color(hex: "43e97b"), Color(hex: "38f9d7")]
        case let s where s.contains("reader") || s.contains("book"):
            colors = [Color(hex: "fa709a"), Color(hex: "fee140")]
        case let s where s.contains("jeans") || s.contains("clothing"):
            colors = [Color(hex: "30cfd0"), Color(hex: "330867")]
        case let s where s.contains("tablet"):
            colors = [Color(hex: "a8edea"), Color(hex: "fed6e3")]
        case let s where s.contains("audio") || s.contains("speaker"):
            colors = [Color(hex: "ff9a9e"), Color(hex: "fecfef")]
        default:
            colors = [ColorTheme.primaryBackground, ColorTheme.accentOrange]
        }
        
        return Gradient(colors: colors)
    }
    
    private func iconForProduct(_ name: String) -> String {
        switch name.lowercased() {
        case let s where s.contains("smartphone") || s.contains("phone"):
            return "iphone"
        case let s where s.contains("earbuds") || s.contains("wireless ear"):
            return "airpodspro"
        case let s where s.contains("headphones") || s.contains("audio"):
            return "headphones"
        case let s where s.contains("shoes") || s.contains("running"):
            return "figure.walk"
        case let s where s.contains("vacuum") || s.contains("cleaner"):
            return "wind"
        case let s where s.contains("reader") || s.contains("book"):
            return "book.fill"
        case let s where s.contains("jeans") || s.contains("clothing") || s.contains("jacket"):
            return "tshirt.fill"
        case let s where s.contains("tablet"):
            return "ipad"
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
        ProductImageView(imageName: "Flagship Smartphone", size: 150)
            .frame(width: 150, height: 150)
        
        ProductImageView(imageName: "Wireless Earbuds Pro", size: 150)
            .frame(width: 150, height: 150)
        
        ProductImageView(imageName: "Running Shoes", size: 150)
            .frame(width: 150, height: 150)
    }
    .padding()
}
