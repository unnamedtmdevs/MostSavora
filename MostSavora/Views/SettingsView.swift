//
//  SettingsView.swift
//  MostSavora
//
//  Created by Simon Bakhanets on 24.01.2026.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: ShoppingViewModel
    @State private var showingDeleteConfirmation = false
    @State private var showingResetConfirmation = false
    
    var body: some View {
        NavigationView {
            Form {
                // Profile Section
                Section(header: Text("PROFILE")) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(ColorTheme.accentOrange)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Guest User")
                                .font(.headline)
                            Text("Premium Member")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.leading, 8)
                    }
                    .padding(.vertical, 8)
                }
                
                // Notifications Section
                Section(header: Text("NOTIFICATIONS")) {
                    Toggle("Push Notifications", isOn: Binding(
                        get: { viewModel.userSettings.notificationsEnabled },
                        set: { value in
                            var settings = viewModel.userSettings
                            settings.notificationsEnabled = value
                            viewModel.updateSettings(settings)
                        }
                    ))
                    
                    Toggle("Price Alerts", isOn: Binding(
                        get: { viewModel.userSettings.priceAlertsEnabled },
                        set: { value in
                            var settings = viewModel.userSettings
                            settings.priceAlertsEnabled = value
                            viewModel.updateSettings(settings)
                        }
                    ))
                    .disabled(!viewModel.userSettings.notificationsEnabled)
                    
                    Toggle("Deal Notifications", isOn: Binding(
                        get: { viewModel.userSettings.dealNotificationsEnabled },
                        set: { value in
                            var settings = viewModel.userSettings
                            settings.dealNotificationsEnabled = value
                            viewModel.updateSettings(settings)
                        }
                    ))
                    .disabled(!viewModel.userSettings.notificationsEnabled)
                    
                    Toggle("Email Notifications", isOn: Binding(
                        get: { viewModel.userSettings.emailNotifications },
                        set: { value in
                            var settings = viewModel.userSettings
                            settings.emailNotifications = value
                            viewModel.updateSettings(settings)
                        }
                    ))
                }
                
                // Preferences Section
                Section(header: Text("PREFERENCES")) {
                    Picker("Currency", selection: Binding(
                        get: { viewModel.userSettings.preferredCurrency },
                        set: { value in
                            var settings = viewModel.userSettings
                            settings.preferredCurrency = value
                            viewModel.updateSettings(settings)
                        }
                    )) {
                        Text("USD ($)").tag("USD")
                        Text("EUR (€)").tag("EUR")
                        Text("GBP (£)").tag("GBP")
                    }
                    
                    NavigationLink(destination: FavoriteCategoriesView()) {
                        HStack {
                            Text("Favorite Categories")
                            Spacer()
                            Text("\(viewModel.userSettings.favoriteCategories.count)")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                // App Info Section
                Section(header: Text("ABOUT")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    NavigationLink(destination: Text("Privacy Policy").navigationTitle("Privacy Policy")) {
                        Text("Privacy Policy")
                    }
                    
                    NavigationLink(destination: Text("Terms of Service").navigationTitle("Terms of Service")) {
                        Text("Terms of Service")
                    }
                    
                    Button(action: {
                        // Open support email or contact form
                    }) {
                        Text("Contact Support")
                    }
                }
                
                // Data Management Section
                Section(header: Text("DATA MANAGEMENT")) {
                    Button(action: {
                        showingResetConfirmation = true
                    }) {
                        HStack {
                            Text("Reset App Data")
                            Spacer()
                            Image(systemName: "arrow.counterclockwise")
                        }
                        .foregroundColor(.orange)
                    }
                    
                    Button(action: {
                        showingDeleteConfirmation = true
                    }) {
                        HStack {
                            Text("Delete Account")
                            Spacer()
                            Image(systemName: "trash")
                        }
                        .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .alert("Reset App Data", isPresented: $showingResetConfirmation) {
                Button("Cancel", role: .cancel) {}
                Button("Reset", role: .destructive) {
                    viewModel.resetApp()
                }
            } message: {
                Text("This will clear all your wishlists and settings. Your app will restart with fresh data.")
            }
            .alert("Delete Account", isPresented: $showingDeleteConfirmation) {
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    viewModel.resetApp()
                }
            } message: {
                Text("This will permanently delete all your data and reset the app. This action cannot be undone.")
            }
        }
    }
}

struct FavoriteCategoriesView: View {
    @EnvironmentObject var viewModel: ShoppingViewModel
    
    var body: some View {
        List {
            ForEach(ProductCategory.allCases, id: \.self) { category in
                Button(action: {
                    toggleCategory(category)
                }) {
                    HStack {
                        Image(systemName: category.iconName)
                            .foregroundColor(ColorTheme.accentOrange)
                            .frame(width: 30)
                        
                        Text(category.rawValue)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        if viewModel.userSettings.favoriteCategories.contains(category) {
                            Image(systemName: "checkmark")
                                .foregroundColor(ColorTheme.accentOrange)
                        }
                    }
                }
            }
        }
        .navigationTitle("Favorite Categories")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func toggleCategory(_ category: ProductCategory) {
        var settings = viewModel.userSettings
        if let index = settings.favoriteCategories.firstIndex(of: category) {
            settings.favoriteCategories.remove(at: index)
        } else {
            settings.favoriteCategories.append(category)
        }
        viewModel.updateSettings(settings)
    }
}

#Preview {
    SettingsView()
        .environmentObject(ShoppingViewModel())
}
