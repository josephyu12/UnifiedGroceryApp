//
//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
//
import SwiftUI
struct RecipeView: View {
    
    
    //accesses recipies
    @ObservedObject var model = ViewModel()    
    
    var body: some View {
        //nav view for redirections
        NavigationView {
            
            ZStack (alignment: .top) {
                
                Color("redcolor").ignoresSafeArea()
                
                Color("bluecolor").edgesIgnoringSafeArea(.top)
                
                ScrollView(showsIndicators: false) {
                    
                    VStack {
                        
                        Text("All Recipes").font(.largeTitle).foregroundColor(Color.black).padding(.top)
                        
                        Spacer()
                        
                        //loops thorugh each recipe and displays all fields
                        ForEach(model.list) { item in
                            
                            
                            NavigationLink(destination: RecipeObjectView(title: item.title, category: item.category, directions: item.directions)) {
                                GroupBox(label: Label(item.title, systemImage: "fork.knife").foregroundColor(.black)) {
                                }
                                .groupBoxStyle(TransparentGroupBox())
                                .padding(.horizontal)
                            }
                            
                            
                        }
                        
                        
                    }
                    Spacer()
                }
            }
            
        }
        
    }
    
    //pulls data on load
    init() {
        model.getData()
    }
    
}
struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}
