//
//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var model = ViewModel()
    
    @State var title = ""
    @State var category = ""
    
    var body: some View {
        ZStack {
            
            
            
            Color("bluecolor").edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Divider()
                
                VStack (spacing: 10) {
                    
                    TextField("Title", text: $title).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Category", text: $category)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        print($title, $category)
                        model.addData(title: title, category: category)
                        
                        title = ""
                        category = ""
                        
                    }, label: {
                        Text("Add Recipe")
                    })
                    
                }
                .padding()
                
            }
            
            /*VStack {
                Spacer()
                Image("logo")
                Spacer()
                HStack {
                    Spacer()
                    Image("card2")
                    Spacer()
                    Image("card3")
                    Spacer()
                }
                Spacer()
                
                Image("dealbutton")
                Spacer()
                
                HStack {
                    Spacer()
                    VStack {
                        Text("asfasfsdafadsf")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 10.0)
                        Text("0")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                        
                    }
                    Spacer()
                    
                    VStack {
                        Text("CPU")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 10.0)
                        Text("0")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                    }
                    Spacer()
                    
                }
                Spacer()
            }*/
            
        }

    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
