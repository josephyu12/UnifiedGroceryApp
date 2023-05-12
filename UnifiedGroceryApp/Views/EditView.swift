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

// function end editing will send the selector to nil

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// make a background structure that allows escaping for the editing view

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
    
    // observe the fridgemodel
    
    @ObservedObject var fridgemodel = FridgeViewModel()
    
    // define blank variables for holding data that will be submitted in the form
    
    @State var ingredient = ""
    @State var category = ""
    @State var amount = ""
    @State var amount_unit = ""
    @State var expiration = Date()
    
    // define list of food categories
    
    var categories = ["Select a Category", "Fruits", "Vegetables", "Grains", "Protein", "Dairy", "Condiments", "Other"]
    
    var body: some View {
        
        // wrap everything in background to enable the editing escape
        
        Background {
            
            // main background that is blue with red bit at bottom for navigation bar overlay
            
            Color("redcolor").ignoresSafeArea()
            
            Color("bluecolor").edgesIgnoringSafeArea(.top)
            
            VStack (spacing: 10) {
                
                // form field for the ingredient name
                
                TextField("Ingredient Name", text: $ingredient) {
                    self.endEditing() }.padding(.all, 10).background(Color.gray).cornerRadius(10).foregroundColor(Color.black)
                
                // form field for the category, dropdown based
                
                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                
                // field for amount
                
                TextField("Amount", text: $amount)
                    .padding(.all, 10).background(Color.gray).cornerRadius(10).foregroundColor(Color.black)
                    .keyboardType(.decimalPad)
                
                // field for amount unit
                
                TextField("Amount Unit", text: $amount_unit)
                    .padding(.all, 10).background(Color.gray).cornerRadius(10).foregroundColor(Color.black)
                
                // field for expiration date
                
                DatePicker("Expiration Date", selection: $expiration, in: Date()..., displayedComponents: .date).foregroundColor(Color.black).padding()
                
                // submit button
                
                Button(action: {
                    
                    print(ingredient)
                    print(category)
                    
                    // pass data to the viewmodel which will submit to firebase
                    
                    fridgemodel.addData(ingredient: ingredient, category: category, amount: amount, amount_unit: amount_unit,
                                        expiration: expiration)
                    
                    // reset the form fields
                    
                    ingredient = ""
                    category = ""
                    amount = ""
                    amount_unit = ""
                    expiration = Date()
                    
                }, label: {
                    
                    // label for submit button
                    Text("Add Ingredient to Fridge")
                    
                    // disable submission if ingredient is blank or category blank
                }).disabled(ingredient.isEmpty || category == "").padding()
                    .background(Color("graycolor"))
                    .foregroundColor(.black)
                    .cornerRadius(22)
                
            }
            .padding()
            
            // if tap elsewhere, end the editing view
            
        }.onTapGesture {
            self.endEditing()
        }
    }
    
    // function to end editing
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
}


struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}
