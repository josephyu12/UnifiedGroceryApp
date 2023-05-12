//
//  AddView.swift
//  UnifiedGroceryApp
//
//  Created by Travis Tran on 5/2/23.
//

import SwiftUI

struct AddView: View {
    
    // observe the fridgemodel which has data
    
    @ObservedObject var fridgemodel = FridgeViewModel()
    
    // define flex columns
    let columns = [
        GridItem(.flexible())
    ]
    
    // define states which will be used in form control
    var updateIngredient: Ingredient
    @State var ingredient: String
    @State var category: String
    @State var amount: String
    @State var amount_unit: String
    @State var expiration: Date
    
    // define list of food categories
    var categories = ["Select a Category", "Fruits", "Vegetables", "Grains", "Protein", "Dairy", "Condiments", "Other"]
    
    // define function to exit editing
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    // main body
    
    var body: some View {
        
        // everything is on a ZStack which will allow background to show
        ZStack (alignment: .top) {

                    
                    Background {
                        
                        // background blue everywhere but a bit of red at botton to accomodate for overlay with ContentView NavBar
                        
                        Color("redcolor").ignoresSafeArea()
                        
                        Color("bluecolor").edgesIgnoringSafeArea(.top)
                        
                        // VStack for the form
                        
                        VStack (spacing: 10) {
                            
                            // field for the ingredient name
                            
                            TextField("Ingredient Name", text: $ingredient) {
                                self.endEditing() }.padding(.all, 10).background(Color.gray).cornerRadius(10).foregroundColor(Color.black)
                            
                            // field for the category
                            
                            Picker("Category", selection: $category) {
                                ForEach(categories, id: \.self) {
                                    Text($0)
                                }
                            }
                            
                            // field for the ingredient amount
                            
                            TextField("Amount", text: $amount)
                                .padding(.all, 10).background(Color.gray).cornerRadius(10).foregroundColor(Color.black)
                                .keyboardType(.decimalPad)
                            
                            // field for the amount unit
                            
                            TextField("Amount Unit", text: $amount_unit)
                                .padding(.all, 10).background(Color.gray).cornerRadius(10).foregroundColor(Color.black)
                            
                            // field for the expiration date, uses a DatePicker
                            
                            DatePicker("Expiration Date", selection: $expiration, in: Date()..., displayedComponents: .date).foregroundColor(Color.black).padding()
                            
                            // submit button
                            
                            Button(action: {
                                
                                print(ingredient)
                                print(category)
                                
                                // update with the relevant fields
                                
                                fridgemodel.updateData(ingredientToUpdate: updateIngredient, ingredient: ingredient, category: category, amount: amount, amount_unit: amount_unit, expiration: expiration)
                                
                                // reset the local fields with blanks
                                
                                ingredient = ""
                                category = ""
                                amount = ""
                                amount_unit = ""
                                expiration = Date()
                                
                            }, label: {
                                
                                // submission button text
                                
                                Text("Update Ingredient")
                                
                                // disabled if there is no ingredient name or category, these are required fields
                                
                            }).disabled(ingredient.isEmpty || category == "").padding()
                                .background(Color("graycolor"))
                                .foregroundColor(.black)
                                .cornerRadius(22)
                            
                        }
                        .padding()
                        
                        
                        // exit editing mode if tap anywhere else on the page
                        
                        
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
