//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
//
import SwiftUI

struct FridgeView: View {
    
    @ObservedObject var fridgemodel = FridgeViewModel()
    
    var categories = ["Select a Category", "Fruits", "Vegetables", "Grains", "Protein", "Dairy", "Condiments", "Other"]
    
    var body: some View {
        
        NavigationView {
            
            ZStack (alignment: .top) {
                
                Color("redcolor").ignoresSafeArea()
                
                Color("bluecolor").edgesIgnoringSafeArea(.top)
                
                ScrollView (showsIndicators: false) {
                    // List {
                    ForEach(categories, id:\.self) { category in
                        
                        let subIngredients = fridgemodel.fridge.filter {$0.category == category}
                        
                        if (subIngredients.isEmpty) {
                            
                        } else {
                            
                            Section(header: Text(category).font(.title).foregroundColor(Color.black).padding(.top)) {
                                ForEach(subIngredients) { item in
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
                                                    
                                                    NavigationLink(destination: AddView(updateIngredient: item, ingredient: item.ingredient, category: item.category, amount: item.amount, amount_unit: item.amount_unit, expiration: item.expiration)) {
                                                        Image(systemName: "pencil")
                                                    }
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
                    
                    Spacer()
                }
                .refreshable {fridgemodel.getData()}
            }
        }
    }
    
    init() {
        fridgemodel.getData()
    }
    
}

struct FridgeView_Previews: PreviewProvider {
    static var previews: some View {
        FridgeView()
    }
}
