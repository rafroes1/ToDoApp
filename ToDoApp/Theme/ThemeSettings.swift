//
//  ThemeSettings.swift
//  ToDoApp
//
//  Created by Rafael Carvalho on 12/04/23.
//

import SwiftUI

class ThemeSettings: ObservableObject {
    @Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
    
    private init() {}
    
    public static let shared = ThemeSettings()
}
