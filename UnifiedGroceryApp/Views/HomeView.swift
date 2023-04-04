//
//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
//

import SwiftUI
// to get date and time
import UIKit

//struct Time {
//    //date and time
//
//    // current date and time
//   var date = Date()
//
//    // Calender dateComponents
//  var   components = Calendar.current.dateComponents([.hour,.minute], from: date)
//   var  hour = components.hour
//   var  minute = components.minute
//
//    // DateFormatter
//    var dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "hh:mm"
//   var  hoursMinutesString = dateFormatter.string(from: date)
//
//
//}


struct HomeView: View {
    
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
