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
            
        }
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
