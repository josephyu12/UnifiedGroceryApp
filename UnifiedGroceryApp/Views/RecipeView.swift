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
        
        NavigationView {
            
            ZStack (alignment: .top) {
                
                Color("redcolor").ignoresSafeArea()
                
                Color("bluecolor").edgesIgnoringSafeArea(.top)
                
                ScrollView(showsIndicators: false) {
                    
                    VStack {
                        
                        Text("Recipes").font(.largeTitle).padding(.top)
                        Spacer()
                        
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
    
    
    init() {
        model.getData()
    }
    
}
struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}
