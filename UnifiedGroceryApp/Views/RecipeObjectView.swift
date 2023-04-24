//
//  RecipeObjectView.swift
//  UnifiedGroceryApp
//
//  Created by Travis Tran on 4/5/23.
//

import SwiftUI

struct RecipeObjectView: View {
    
    
    let columns = [
        GridItem(.flexible())
    ]
    
    
    var body: some View {
        ZStack (alignment: .top) {
            Color("redcolor").ignoresSafeArea()
            
            Color("bluecolor").edgesIgnoringSafeArea(.top)
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    
                    HStack {
                        Button(action: {
                            print("this is the action run")
                        }) {
                            Image(systemName: "chevron.backward").foregroundColor(Color.black).padding(.bottom, 0.0).font(.system(size:24))
                        }
                    }.frame(alignment: .leading)
                    
                    
                    Text("Good Morning")
                        .font(.largeTitle)
            
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        
                        GroupBox(label: Label("Breakfast", systemImage: "fork.knife").foregroundColor(.black).font(.largeTitle)) {
                            Text("Breakfast Recommendation")
                        }
                        .groupBoxStyle(TransparentGroupBox())
                        .padding(.horizontal)
                        GroupBox(label: Label("Lunch", systemImage: "fork.knife").foregroundColor(.black).font(.largeTitle)) {
                            Text("Lunch Recommendation")
                        }
                        .groupBoxStyle(TransparentGroupBox())
                        .padding(.horizontal)
                        GroupBox(label: Label("Dinner", systemImage: "fork.knife").foregroundColor(.black).font(.largeTitle)) {
                            Text("Dinner Recommendation")
                        }
                        .groupBoxStyle(TransparentGroupBox())
                        .padding(.horizontal)
                        
                        GroupBox(label: Label("Expiring Ingredients", systemImage: "fork.knife").foregroundColor(.black).font(.largeTitle)) {
                            Text("These ingredients are going to expire")
                        }
                        .groupBoxStyle(TransparentGroupBox())
                        .padding(.horizontal)
                        
                        
                    }
                }
            }
        }
    }
}

struct RecipeObjectView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeObjectView()
    }
}
