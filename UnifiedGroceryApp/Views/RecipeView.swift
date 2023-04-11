//
//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
//

import SwiftUI


struct RecipeView: View {
    
    @ObservedObject var model = ViewModel()
      
    private var gridLayout = [GridItem(.flexible())]
    
    private var colors: [Color] = [.yellow, .purple, .green]
    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    
    
    var body: some View {
        
        ZStack {
            
//            ZStack (alignment: .top) {
//
//                Color("redcolor").ignoresSafeArea()
//
//                Color("bluecolor").edgesIgnoringSafeArea(.top)
//
//                ScrollView(showsIndicators: false) {
//                    VStack {
//                        Color("bluecolor").edgesIgnoringSafeArea(.all)
//                        Text("Recipes").font(.largeTitle).padding(.top, 0.1)
//
//
//                        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
//
//                            ForEach((0...9), id: \.self) {
//                                Button(action: {print("this is the action run")} ) {
//                                    Image(systemName: "gear").foregroundColor(Color.black)
//                                        .padding(0).font(.system(size:24))
//                                    Text("test123")
//                                        .font(.system(size: 30))
//                                        .foregroundColor(Color.black)
//                                }.font(.system(size: 30))
//                                    .frame(minWidth: 0, maxWidth: UIScreen.screenWidth-10)
//                                    .background(colors[$0 % colors.count])
//                                    .cornerRadius(10)
//                            }
//
//
//
//                        }
//
//
//                    }
//
//                }
//
//            }
            
            Color("redcolor").ignoresSafeArea()
            
            Color("bluecolor").edgesIgnoringSafeArea(.all)
            
            List(model.list) { item in
                HStack {
                    Text(item.title)
                    Spacer()
                    
                    Button(action: {
                        model.updateData(recipeToUpdate: item)
                    }, label: {
                        Image(systemName: "pencil")
                    })
                    .buttonStyle(BorderlessButtonStyle())
                    
                    Button(action: {
                        model.deleteData(recipeToDelete: item)
                    }, label: {
                        Image(systemName: "minus.circle")
                    }).buttonStyle(BorderlessButtonStyle())
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
