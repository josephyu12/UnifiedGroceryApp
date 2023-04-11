//
//  Ingredient.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 4/10/23.
//

import Foundation

struct Ingredient: Identifiable {
    
    var id: String
    var ingredient: String
    var category: String?
    var amount: Float?
    var amount_unit: String?
    var expiration: Double?
    
}
