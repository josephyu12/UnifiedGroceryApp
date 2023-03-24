//
//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        ZStack {
            
            Color("bluecolor").ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    
                    Text("this is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\n")
                        .multilineTextAlignment(.leading)
                        .padding(.top)
                    
                    Text("this is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\n")
                        .multilineTextAlignment(.leading)
                    
                }
                
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
