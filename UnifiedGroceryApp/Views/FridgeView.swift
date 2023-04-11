//
//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
//

import SwiftUI

struct FridgeView: View {
    
    @ObservedObject var fridgemodel = FridgeViewModel()
    
    var body: some View {
        ZStack {
            
            Color("bluecolor").edgesIgnoringSafeArea(.all)
            
            List(fridgemodel.fridge) { item in
                HStack {
                    Text(item.ingredient)
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
