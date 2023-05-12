//
//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
//

import SwiftUI

// variables based on screen size for formatting

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}



struct ContentView: View {
    
    // initialize, make the Tab navigation bar appear red with white text
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        UITabBar.appearance().barTintColor = UIColor(Color("redcolor"))
    }
    
    var body: some View {
        
        // vertical stack of heading and main body
        
        VStack(spacing: 0) {
            
            // red header with app name text, takes up the top section only
            
            ZStack{
                Color("redcolor").ignoresSafeArea()
                HStack {
                    
                    Text("Unified Grocery App").foregroundColor(Color.black)
                        .padding(.leading).font(.system(size:24))

                    Spacer()

                }
            }
            .padding(0.0)
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/20)
            
            // main body, a TabView that allows access between different pages
            
            TabView {
                Group {
                    
                    // link to home page
                    HomeView()
                        .padding(0.0)
                        .tabItem() {
                            Image(systemName: "house")
                            Text("Home")
                        }
                    
                    // link to all recipes page
                    RecipeView()
                        .tabItem() {
                            Image(systemName: "list.clipboard")
                            Text("Recipes")
                        }
                    
                    // link to fridge page with ingredients
                    FridgeView()
                        .tabItem() {
                            Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                            Text("Fridge")
                        }
                    
                    // link to edit page to add ingredients
                    EditView()
                        .tabItem() {
                            Image(systemName: "plus")
                            Text("Add")
                            
                        }
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
