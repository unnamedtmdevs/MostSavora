//
//  UserSettings.swift
//  MostSavora
//
//  Created by Simon Bakhanets on 24.01.2026.
//

import Foundation

struct UserSettings: Codable {
    var notificationsEnabled: Bool
    var priceAlertsEnabled: Bool
    var dealNotificationsEnabled: Bool
    var preferredCurrency: String
    var favoriteCategories: [ProductCategory]
    var emailNotifications: Bool
    var darkModeEnabled: Bool
    
    init(
        notificationsEnabled: Bool = true,
        priceAlertsEnabled: Bool = true,
        dealNotificationsEnabled: Bool = true,
        preferredCurrency: String = "USD",
        favoriteCategories: [ProductCategory] = [],
        emailNotifications: Bool = false,
        darkModeEnabled: Bool = false
    ) {
        self.notificationsEnabled = notificationsEnabled
        self.priceAlertsEnabled = priceAlertsEnabled
        self.dealNotificationsEnabled = dealNotificationsEnabled
        self.preferredCurrency = preferredCurrency
        self.favoriteCategories = favoriteCategories
        self.emailNotifications = emailNotifications
        self.darkModeEnabled = darkModeEnabled
    }
    
    static var `default`: UserSettings {
        UserSettings()
    }
}
