//
//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var fridgemodel = FridgeViewModel()
    
    @State var ingredient = ""
    @State var category = ""
    @State var amount = ""
    @State var amount_unit = ""
    
    @State var selectedCategory = ""
    
    var categories = ["Fruits", "Vegetables", "Grains", "Protein", "Dairy", "Condiments", "Other"]
    
    var body: some View {
        ZStack {
            
            Color("bluecolor").edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Divider()
                
                VStack (spacing: 10) {
                    
                    TextField("Ingredient Name", text: $ingredient).textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextField("Amount", text: $amount)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                    
                    TextField("Amount Unit", text: $amount_unit)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        fridgemodel.addData(ingredient: ingredient, category: category, amount: amount as? Float ?? 0.0, amount_unit: amount_unit)
                        
                        ingredient = ""
                        category = ""
                        amount = ""
                        amount_unit = ""
                        
                    }, label: {
                        Text("Add Ingredient to Fridge")
                    }).disabled(ingredient.isEmpty)
                    
                }
                .padding()
                
            }
            
        }
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
