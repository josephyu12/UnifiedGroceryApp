//
//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
//

import SwiftUI


struct RecipeView: View {
    
    @ObservedObject var model = ViewModel()
    
    
    let rows = 2
    let columns = 5
    
    let numbers = Array(1...10)
    
    
    var body: some View {
        
        ZStack (alignment: .top) {
            
            Color("redcolor").ignoresSafeArea()
            
            Color("bluecolor").edgesIgnoringSafeArea(.top)
            
            VStack {
                Text("Recipes").font(.largeTitle).padding(.top)
                
                HStack {
                    
                    List(model.list) { item in
                        
                        Text(item.title)
                        Color("bluecolor")
                        
                    }
                    
                    
                }
                

            }
            
        }
        
    }
    
    
    init() {
        model.getData()
    }
    
}


struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}
