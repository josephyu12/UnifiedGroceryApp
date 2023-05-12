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
            
            Color("redcolor").ignoresSafeArea()
            
            Color("bluecolor").edgesIgnoringSafeArea(.top)
            
            VStack (spacing: 10) {
                
                TextField("Ingredient Name", text: $ingredient) {
                    self.endEditing() }.padding(.all, 10).background(Color.gray).cornerRadius(10).foregroundColor(Color.black)
                
                
                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .padding(.all, 10).background(Color.gray).cornerRadius(10).foregroundColor(Color.black)
                    .keyboardType(.decimalPad)
                
                TextField("Amount Unit", text: $amount_unit)
                    .padding(.all, 10).background(Color.gray).cornerRadius(10).foregroundColor(Color.black)
                
                DatePicker("Expiration Date", selection: $expiration, in: Date()..., displayedComponents: .date).foregroundColor(Color.black).padding()
                
                Button(action: {
                    
                    print(ingredient)
                    print(category)
                    
                    fridgemodel.addData(ingredient: ingredient, category: category, amount: amount, amount_unit: amount_unit,
                                        expiration: expiration)
                    
                    ingredient = ""
                    category = ""
                    amount = ""
                    amount_unit = ""
                    expiration = Date()
                    
                }, label: {
                    Text("Add Ingredient to Fridge")
                }).disabled(ingredient.isEmpty || category == "").padding()
                    .background(Color("graycolor"))
                    .foregroundColor(.black)
                    .cornerRadius(22)
                
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
