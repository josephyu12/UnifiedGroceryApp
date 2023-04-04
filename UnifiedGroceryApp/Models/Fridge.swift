//
//  Fridge.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 4/3/23.
//

import Foundation

struct Fridge: Identifiable {
    
    var id: String
    var amount: Float
    var amount_unit: String
    var category: String
    var expiration_date: TimeInterval
    
}
