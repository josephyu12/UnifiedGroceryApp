//
//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem() {
                    Image(systemName: "house")
                    Text("Home")
                }
            RecipeView()
                .tabItem() {
                    Image(systemName: "list.clipboard")
                    Text("Recipes")
                }
            FridgeView()
                .tabItem() {
                    Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                    Text("Fridge")
                }
            AddView()
                .tabItem() {
                    Image(systemName: "plus")
                    Text("Add")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
