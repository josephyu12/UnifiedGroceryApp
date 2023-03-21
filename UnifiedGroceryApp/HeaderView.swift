//
//  HeaderView.swift
//  UnifiedGroceryApp
//
//  Created by Travis Tran on 3/21/23.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        ZStack {
            Color("redcolor")
            
            HStack {
                Text("[Insert Title Here]").foregroundColor(Color.black)
                    .padding(.leading).font(.system(size:24))
                
                
                Spacer()
                
                Button(action: {
                    print("this is the action run")
                }) {
                    Image(systemName: "gear").foregroundColor(Color.black)
                        .padding(.trailing).font(.system(size:24))
                }
                
                
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView().previewLayout(.fixed(width: 375,height: 80))
    }
}
