//
//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
//

import SwiftUI

struct RecipeView: View {
    
    @ObservedObject var model = ViewModel()
    
    var body: some View {
        ZStack {
                
                Color("bluecolor").edgesIgnoringSafeArea(.all)
            
                List(model.list) { item in Text(item.title) }
                
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
