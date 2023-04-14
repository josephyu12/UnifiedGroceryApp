//
//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct Background<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
 
    var body: some View {
        Color("bluecolor").edgesIgnoringSafeArea(.all)
            .overlay(content)
    }
}

struct AddView: View {
    
    @ObservedObject var fridgemodel = FridgeViewModel()
    
    @State var ingredient = ""
    @State var category = ""
    @State var amount = ""
    @State var amount_unit = ""
    
    @State var selectedCategory = ""
    
    var categories = ["Fruits", "Vegetables", "Grains", "Protein", "Dairy", "Condiments", "Other"]
    
    var body: some View {
        
//        ZStack (alignment: .top) {
        
        Background {
            
                VStack (spacing: 10) {
                    
                    TextField("Ingredient Name", text: $ingredient) {
                        self.endEditing() }.textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextField("Amount", text: $amount)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    
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
                
            
        }.onTapGesture {
            self.endEditing()
        }
    }
    
    private func endEditing() {
            UIApplication.shared.endEditing()
        }
        
    }


struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
