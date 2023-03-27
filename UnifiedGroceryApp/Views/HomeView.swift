//
//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
            
            ZStack (alignment: .top) {
                
                Color("redcolor").ignoresSafeArea()
            
                //            Color("bluecolor").ignoresSafeArea()
                Color("bluecolor").edgesIgnoringSafeArea(.top)
                
                ScrollView(showsIndicators: false) {
                    
                    VStack {
                        
                        Text("this is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\n")
                            .multilineTextAlignment(.leading)
                            .padding(.top)
                        
                        Text("this is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\n")
                            .multilineTextAlignment(.leading)
                        
                    }
                    
                    
                }
                
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
