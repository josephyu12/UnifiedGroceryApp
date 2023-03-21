//
//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            ZStack{
                Color("redcolor").ignoresSafeArea()
                HStack {
                    
                    Text("[Insert Title Here]").foregroundColor(Color.black)
                        .padding(.leading).font(.system(size:24))
                    
                    
                    Spacer()
                    
                    Button(action: {
                        print("this is the action run")
                    }) {
                        Image(systemName: "gear").foregroundColor(Color.black)
                            .padding(.trailing).font(.system(size:24))
                    }
                    
                    
                }
            }
            .padding(0.0)
            .frame(width: 400, height: 65.0)
            
            
            TabView {
                HomeView()
                    .padding(0.0)
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
            .padding(0.0)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
