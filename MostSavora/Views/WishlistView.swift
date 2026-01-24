//
//  WishlistView.swift
//  MostSavora
//
//  Created by Simon Bakhanets on 24.01.2026.
//

import SwiftUI

struct WishlistView: View {
    @EnvironmentObject var viewModel: ShoppingViewModel
    @State private var showingCreateWishlist = false
    @State private var showingEditItem: WishlistItem?
    @State private var newWishlistName = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                ColorTheme.secondaryBackground
                    .ignoresSafeArea()
                
                if viewModel.wishlists.isEmpty {
                    // Empty state
                    VStack(spacing: 20) {
                        Image(systemName: "heart.slash")
                            .font(.system(size: 80))
                            .foregroundColor(.gray)
                        
                        Text("No Wishlists Yet")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Create your first wishlist to start tracking your favorite items")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                        
                        Button(action: {
                            showingCreateWishlist = true
                        }) {
                            Text("Create Wishlist")
                                .primaryButton()
                        }
                        .padding(.horizontal, 40)
                        .padding(.top, 20)
                    }
                } else {
                    List {
                        ForEach(viewModel.wishlists) { wishlist in
                            Section(header: WishlistHeader(wishlist: wishlist)) {
                                if wishlist.items.isEmpty {
                                    Text("No items in this wishlist")
                                        .foregroundColor(.secondary)
                                        .italic()
                                } else {
                                    ForEach(wishlist.items) { item in
                                        WishlistItemRow(item: item)
                                            .onTapGesture {
                                                showingEditItem = item
                                            }
                                    }
                                    .onDelete { indexSet in
                                        deleteItems(from: wishlist, at: indexSet)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationTitle("Wishlists")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingCreateWishlist = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(ColorTheme.accentOrange)
                    }
                }
            }
            .sheet(isPresented: $showingCreateWishlist) {
                CreateWishlistSheet(
                    wishlistName: $newWishlistName,
                    onCreate: {
                        if !newWishlistName.isEmpty {
                            viewModel.createWishlist(name: newWishlistName)
                            newWishlistName = ""
                            showingCreateWishlist = false
                        }
                    }
                )
            }
            .sheet(item: $showingEditItem) { item in
                EditWishlistItemSheet(item: item)
                    .environmentObject(viewModel)
            }
        }
    }
    
    private func deleteItems(from wishlist: Wishlist, at offsets: IndexSet) {
        for index in offsets {
            let item = wishlist.items[index]
            viewModel.removeFromWishlist(item: item)
        }
    }
}

struct WishlistHeader: View {
    let wishlist: Wishlist
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(wishlist.name)
                    .font(.headline)
                    .foregroundColor(ColorTheme.textOnLight)
                
                Text("\(wishlist.items.count) items • Total: \(wishlist.totalValue.formatAsCurrency())")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if wishlist.isShared {
                Image(systemName: "person.2.fill")
                    .font(.caption)
                    .foregroundColor(ColorTheme.accentOrange)
            }
        }
    }
}

struct WishlistItemRow: View {
    let item: WishlistItem
    
    var body: some View {
        HStack(spacing: 12) {
            // Product image
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(ColorTheme.primaryBackground.opacity(0.1))
                    .frame(width: 60, height: 60)
                
                Image(systemName: item.productImageURL)
                    .font(.system(size: 25))
                    .foregroundColor(ColorTheme.primaryBackground)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.productName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                
                HStack(spacing: 4) {
                    Text(item.formattedCurrentPrice)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(ColorTheme.accentOrange)
                    
                    if item.priceAlertEnabled, let targetPrice = item.targetPrice {
                        Image(systemName: "arrow.down.circle.fill")
                            .font(.caption)
                            .foregroundColor(item.isPriceAtTarget ? .green : .orange)
                        Text("Target: \(item.formattedTargetPrice)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                if item.isPriceAtTarget {
                    HStack(spacing: 4) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.caption)
                        Text("Price goal reached!")
                            .font(.caption)
                    }
                    .foregroundColor(.green)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}

struct CreateWishlistSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var wishlistName: String
    let onCreate: () -> Void
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Wishlist Name", text: $wishlistName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: onCreate) {
                    Text("Create")
                        .primaryButton()
                }
                .padding(.horizontal)
                .disabled(wishlistName.isEmpty)
                
                Spacer()
            }
            .padding(.top)
            .navigationTitle("New Wishlist")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct EditWishlistItemSheet: View {
    @EnvironmentObject var viewModel: ShoppingViewModel
    @Environment(\.presentationMode) var presentationMode
    let item: WishlistItem
    
    @State private var priceAlertEnabled: Bool
    @State private var targetPrice: String
    @State private var notes: String
    
    init(item: WishlistItem) {
        self.item = item
        _priceAlertEnabled = State(initialValue: item.priceAlertEnabled)
        _targetPrice = State(initialValue: item.targetPrice != nil ? String(format: "%.2f", item.targetPrice!) : "")
        _notes = State(initialValue: item.notes)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product")) {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(ColorTheme.primaryBackground.opacity(0.1))
                                .frame(width: 60, height: 60)
                            
                            Image(systemName: item.productImageURL)
                                .font(.system(size: 25))
                                .foregroundColor(ColorTheme.primaryBackground)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(item.productName)
                                .font(.headline)
                            Text(item.formattedCurrentPrice)
                                .font(.subheadline)
                                .foregroundColor(ColorTheme.accentOrange)
                        }
                    }
                }
                
                Section(header: Text("Price Alert")) {
                    Toggle("Enable Price Alert", isOn: $priceAlertEnabled)
                    
                    if priceAlertEnabled {
                        HStack {
                            Text("Target Price")
                            Spacer()
                            TextField("0.00", text: $targetPrice)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .frame(width: 100)
                        }
                    }
                }
                
                Section(header: Text("Notes")) {
                    TextEditor(text: $notes)
                        .frame(height: 100)
                }
                
                Section {
                    Button(action: {
                        viewModel.removeFromWishlist(item: item)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Spacer()
                            Text("Remove from Wishlist")
                                .foregroundColor(.red)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Edit Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        var updatedItem = item
                        updatedItem.priceAlertEnabled = priceAlertEnabled
                        updatedItem.targetPrice = Double(targetPrice)
                        updatedItem.notes = notes
                        
                        viewModel.updateWishlistItem(updatedItem)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    WishlistView()
        .environmentObject(ShoppingViewModel())
}
