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

        ZStack (alignment: .top) {
                Color("redcolor").ignoresSafeArea()
            
            Color("bluecolor").edgesIgnoringSafeArea(.all)
            
            List {
                
                ForEach(categories, id:\.self) { category in
                    
                    let subIngredients = fridgemodel.fridge.filter {$0.category == category}
                    
                    if (subIngredients.isEmpty) {
                        
                    } else {
                        
                        Section(category) {
                            ForEach(subIngredients) { item in
                                
                                
                                HStack {
                                    VStack(alignment: .leading) {
                                        // title

                                        Text(item.ingredient).font(.title2)

                                        // below info

                                        HStack {

                                            Text(item.amount)

                                            Text(item.amount_unit)
                                            
                                        }

                                    }

                                    Spacer()

                                    Button(action: {
                                        fridgemodel.updateData(ingredientToUpdate: item)
                                    }, label: {
                                        Image(systemName: "pencil")
                                    })
                                    .buttonStyle(BorderlessButtonStyle())

                                    Button(action: {
                                        fridgemodel.deleteData(ingredientToDelete: item)
                                    }, label: {
                                        Image(systemName: "minus.circle")
                                    }).buttonStyle(BorderlessButtonStyle())
                                }
                                
                                
                            }
                        }
        
                    }
                    
                }
                
                
                
                
            }.refreshable {
                fridgemodel.getData()
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
