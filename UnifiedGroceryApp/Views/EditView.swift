//
//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
//

// 1. Fix keyboard dismissal
// 2. Fridge Seperation
// 3. Make Add View Better, Camera Detection?
// 4. Edit Ingredient Item

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

struct EditView: View {
    
    @ObservedObject var fridgemodel = FridgeViewModel()
    
    @State var ingredient = ""
    @State var category = ""
    @State var amount = ""
    @State var amount_unit = ""
    @State var expiration = Date()
    
    var categories = ["Select a Category", "Fruits", "Vegetables", "Grains", "Protein", "Dairy", "Condiments", "Other"]
    
    var body: some View {
        
//        ZStack (alignment: .top) {
        
        Background {
            
                VStack (spacing: 10) {
                    
                    TextField("Ingredient Name", text: $ingredient) {
                        self.endEditing() }.textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextField("Amount", text: $amount)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    
                    TextField("Amount Unit", text: $amount_unit)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    DatePicker("Expiration Date", selection: $expiration, in: Date()..., displayedComponents: .date)
                    
                    Button(action: {
                        
                        print(ingredient)
                        print(category)
                        
                        fridgemodel.addData(ingredient: ingredient, category: category, amount: Float(amount) ?? 0, amount_unit: amount_unit,
                            expiration: expiration)
                        
                        ingredient = ""
                        category = ""
                        amount = ""
                        amount_unit = ""
                        expiration = Date()
                        
                    }, label: {
                        Text("Add Ingredient to Fridge")
                    }).disabled(ingredient.isEmpty || category == "")
                    
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


struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}
