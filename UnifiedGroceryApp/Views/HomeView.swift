//
//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
//

import SwiftUI
// to get date and time
import UIKit


struct HomeView: View {
    
    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    
    private var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    private var colors: [Color] = [.yellow, .purple, .green]
    
    
    let timeZone = Int(TimeZone.current.secondsFromGMT())
    let currentDateTime = Date()
    
    var body: some View {
        
        ZStack (alignment: .top) {
            
            Color("redcolor").ignoresSafeArea()
            
            Color("bluecolor").edgesIgnoringSafeArea(.top)
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    
                    if ((Int(currentDateTime.timeIntervalSince1970)+timeZone)%86400<43200) {
                        Text("Good Morning")
                            .font(.largeTitle).padding(.top)
                    } else if ((Int(currentDateTime.timeIntervalSince1970)+timeZone)%86400>1) {
                        Text("Good Afternoon").font(.largeTitle).padding(.top)
                    } else {
                        Text("Good Evening").font(.largeTitle).padding(.top)
                    }
                    
                                            LazyVGrid(columns: threeColumnGrid, spacing: 20) {
                                                        ForEach((0...9999), id: \.self) {
                                                            Image(systemName: symbols[$0 % symbols.count])
                                                                .font(.system(size: 30))
                                                                .frame(width: 50, height: 50)
                                                                .background(colors[$0 % colors.count])
                                                                .cornerRadius(10)
                                                        }
                                            }
                    
                    Text("this is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\nthis is sample filler text\n")
                        .multilineTextAlignment(.leading)
                        .padding(.top, 0.1)
                    
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
