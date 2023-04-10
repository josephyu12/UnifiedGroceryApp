//
//  ContentView.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 1/27/23.
//

import SwiftUI

struct FridgeView: View {
    
    var body: some View {
        ZStack (alignment: .top) {
            Color("redcolor").ignoresSafeArea()
            Color("bluecolor").edgesIgnoringSafeArea(.top)
                
            }
            
        }

}

struct FridgeView_Previews: PreviewProvider {
    static var previews: some View {
        FridgeView()
    }
}
