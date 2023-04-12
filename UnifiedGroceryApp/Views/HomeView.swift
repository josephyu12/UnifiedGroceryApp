//
//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
// expiration dates
// dinner/breakfast/lunch with missing ingredients
// top 3

import SwiftUI
// to get date and time
import UIKit

struct TransparentGroupBox: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
            VStack {
                HStack {
                    configuration.label
                        .font(.headline)
                    Spacer()
                }
                
                configuration.content
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color("redcolor")))
        }
}



struct HomeView: View {
    
    let timeZone = Int(TimeZone.current.secondsFromGMT())
    let currentDateTime = Date()
    let data = (1...100).map { "Item \($0)" }
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ZStack (alignment: .top) {
            
            Color("redcolor").ignoresSafeArea()
            
            Color("bluecolor").edgesIgnoringSafeArea(.top)
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    
                    if ((Int(currentDateTime.timeIntervalSince1970)+timeZone)%86400<43200) {
                        Text("Good Morning")
                            .font(.largeTitle).padding(.top)
                    } else if ((Int(currentDateTime.timeIntervalSince1970)+timeZone)%86400<61200) {
                        Text("Good Afternoon").font(.largeTitle).padding(.top)
                    } else {
                        Text("Good Evening").font(.largeTitle).padding(.top)
                    }
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        if ((Int(currentDateTime.timeIntervalSince1970)+timeZone)%86400<43200) {
                            GroupBox(label: Label("Breakfast", systemImage: "fork.knife.fill").foregroundColor(Color("redcolor")).font(.largeTitle)) {
                                Text("Breakfast Recommendation")
                            }
                            .padding(.horizontal)
                            GroupBox(label: Label("Lunch", systemImage: "heart.fill").foregroundColor(.red).font(.largeTitle)) {
                                Text("Lunch Recommendation")
                            }
                            .padding(.horizontal)
                            GroupBox(label: Label("Dinner", systemImage: "heart.fill").foregroundColor(.red).font(.largeTitle)) {
                                Text("Dinner Recommendation")
                            }
                            .padding(.horizontal)
                        } else if ((Int(currentDateTime.timeIntervalSince1970)+timeZone)%86400<61200) {
                            GroupBox(label: Label("Lunch", systemImage: "fork.knife").foregroundColor(Color("bluecolor")).font(.largeTitle)) {
                                Text("Lunch Recommendation")
                            }
                            .groupBoxStyle(TransparentGroupBox())
                            .padding(.horizontal)
                            
                            GroupBox(label: Label("Dinner", systemImage: "heart.fill").foregroundColor(.red).font(.largeTitle)) {
                                Text("Dinner Recommendation")
                            }
                            .padding(.horizontal)
                            
                            
                            
                            
                        } else {
                            GroupBox(label: Label("Dinner", systemImage: "heart.fill").foregroundColor(.red).font(.largeTitle)) {
                                Text("Dinner Recommendation")
                            }
                            .padding(.horizontal)
                        }
                        GroupBox(label: Label("Expiring Ingredients", systemImage: "heart.fill").foregroundColor(.red).font(.largeTitle)) {
                            Text("These ingredients are going to expire")
                        }
                        .padding(.horizontal)
                        
                        
                    }
                    
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
