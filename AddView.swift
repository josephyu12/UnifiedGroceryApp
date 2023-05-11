//
//  AddView.swift
//  UnifiedGroceryApp
//
//  Created by Travis Tran on 5/2/23.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var fridgemodel = FridgeViewModel()
    
    let columns = [
        GridItem(.flexible())
    ]
    var updateIngredient: Ingredient
    @State var ingredient: String
    @State var category: String
    @State var amount: String
    @State var amount_unit: String
    @State var expiration: Date
    var categories = ["Select a Category", "Fruits", "Vegetables", "Grains", "Protein", "Dairy", "Condiments", "Other"]
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    var body: some View {
        ZStack (alignment: .top) {
            Color("redcolor").ignoresSafeArea()
            
            Color("bluecolor").edgesIgnoringSafeArea(.top)
            

                
                    
                   
                    
                    
                    
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
                                
                                fridgemodel.updateData(ingredientToUpdate: updateIngredient, ingredient: ingredient, category: category, amount: amount, amount_unit: amount_unit, expiration: expiration)
                                
                                ingredient = ""
                                category = ""
                                amount = ""
                                amount_unit = ""
                                expiration = Date()
                                
                            }, label: {
                                Text("Update Ingredient")
                            }).disabled(ingredient.isEmpty || category == "")
                            
                        }
                        .padding()
                        
                        
                    }.onTapGesture {
                        self.endEditing()
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                
                
            
            
        }
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(updateIngredient: Ingredient(id: "", ingredient: "", category: "", amount: "", amount_unit: "", expiration: Date()), ingredient: "ingredient will appear here", category: "category will appear here", amount: "amount will appear here", amount_unit: "amount unit will appear here", expiration: Date())
    }
}
