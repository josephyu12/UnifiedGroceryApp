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
    var image: Image?
    var title: String
    var category: String
    var directions: String
    var ingredient01: String?
    var ingredient02: String?
    var ingredient03: String?
    var ingredient04: String?
    var ingredient05: String?
    var ingredient06: String?
    var ingredient07: String?
    var ingredient08: String?
    var ingredient09: String?
    var ingredient10: String?
    var unit01: String?
    var unit02: String?
    var unit03: String?
    var unit04: String?
    var unit05: String?
    var unit06: String?
    var unit07: String?
    var unit08: String?
    var unit09: String?
    var unit10: String?
    var qty01: Float?
    var qty02: Float?
    var qty03: Float?
    var qty04: Float?
    var qty05: Float?
    var qty06: Float?
    var qty07: Float?
    var qty08: Float?
    var qty09: Float?
    var qty10: Float?
    
    
    var body: some View {
        ZStack (alignment: .top) {
            Color("redcolor").ignoresSafeArea()
            
            Color("bluecolor").edgesIgnoringSafeArea(.top)
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    
//                    Text(title)
//                        .font(.largeTitle)
//                        .multilineTextAlignment(.center)
            
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        
                        GroupBox(label: Label(title, systemImage: "fork.knife").padding(.bottom).foregroundColor(.black).font(.largeTitle)) {
                            if (category != "") {
                                Text("Category: \(category)")
                                    .foregroundColor(Color.black)
                                    .font(.title2)
                                    .padding(.bottom)
                            }
                            Spacer()
                            Text(directions)
                                .foregroundColor(Color.black)
                        }
                        .groupBoxStyle(TransparentGroupBox())
                        .padding([.top, .leading, .trailing])
                    }
                }
            }
        }
    }
}
struct RecipeObjectView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeObjectView(title: "title will appear here", category: "category will appear here", directions: "directions will appear here")
    }
}
