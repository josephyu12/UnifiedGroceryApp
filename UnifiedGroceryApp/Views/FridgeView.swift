//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
//
import SwiftUI

struct FridgeView: View {
    
    // observes fridge model with the fridge ingredient list
    
    @ObservedObject var fridgemodel = FridgeViewModel()
    
    // list of food categories
    
    var categories = ["Select a Category", "Fruits", "Vegetables", "Grains", "Protein", "Dairy", "Condiments", "Other"]
    
    var body: some View {
        
        // wrap everything in a navigation view to keep headers consistent
        
        NavigationView {
            
            ZStack (alignment: .top) {
                
                // background is blue with red bar at bottom to help with navigation bar overlay
                
                Color("redcolor").ignoresSafeArea()
                
                Color("bluecolor").edgesIgnoringSafeArea(.top)
                
                // main body is scrollable
                
                ScrollView (showsIndicators: false) {
                    
                    // for each of the categories,
                    
                    ForEach(categories, id:\.self) { category in
                        
                        // get ingredients that just belong to that category
                        
                        let subIngredients = fridgemodel.fridge.filter {$0.category == category}
                        
                        if (subIngredients.isEmpty) {
                            
                        } else {
                            
                            // make a section for that category
                            
                            Section(header: Text(category).font(.title).foregroundColor(Color.black).padding(.top)) {
                                
                                // list all ingredients in that category
                                
                                ForEach(subIngredients) { item in
                                    
                                    // object for each of the ingredients, displays ingredient name, amount and units, and expiration date
                                    
                                            GroupBox(label: Label(item.ingredient, systemImage: "fork.knife").foregroundColor(.black)) {
                                                
                                                HStack {
                                                    
                                                    Text(item.amount)
                                                        .foregroundColor(Color.black)
                                                    Text("|")
                                                        .foregroundColor(Color.black)
                                                    Text(item.amount_unit)
                                                        .foregroundColor(Color.black)
                                                    Text("|")
                                                        .foregroundColor(Color.black)
                                                    HStack {
                                                        Text("Expiration Date:")
                                                            .foregroundColor(Color.black)
                                                        Text(item.expiration, style: .date)
                                                            .foregroundColor(Color.black)
                                                        
                                                    }
                                                    
                                                    Spacer()
                                                    
                                                    // if click on edit, will link to the AddView page with the relevant information
                                                    
                                                    NavigationLink(destination: AddView(updateIngredient: item, ingredient: item.ingredient, category: item.category, amount: item.amount, amount_unit: item.amount_unit, expiration: item.expiration)) {
                                                        Image(systemName: "pencil")
                                                    }
                                                    
                                                    // if delete button is clicked, the item will be deleted
                                                    
                                                    Button(action: {fridgemodel.deleteData(ingredientToDelete: item)}, label: {Image(systemName:"minus.circle")})
                                                        .buttonStyle(BorderlessButtonStyle())
                                                }
                                                
                                                
                                                
                                            }
                                            .groupBoxStyle(TransparentGroupBox())
                                            .padding(.horizontal)

                                }
                            }
                            
                        }

                    }
                    
                    // spacer from bottom
                    
                    Spacer()
                    
                    // make function refreshable for new changes
                }
                .refreshable {fridgemodel.getData()}
            }
        }
    }
    
    // on load get data
    
    init() {
        fridgemodel.getData()
    }
    
}

struct FridgeView_Previews: PreviewProvider {
    static var previews: some View {
        FridgeView()
    }
}
