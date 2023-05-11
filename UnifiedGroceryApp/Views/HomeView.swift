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
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(Color("redcolor")))
    }
}
struct HomeView: View {
    
//    @ObservedObject var breakfast = RecommenderViewModel()
    
    let timeZone = Int(TimeZone.current.secondsFromGMT())
    let currentDateTime = Date()
    let data = (1...100).map { "Item \($0)" }
    let columns = [
        GridItem(.flexible())
    ]
    
    @ObservedObject var recommender = RecommenderViewModel()
    
    var body: some View {
        
        ZStack (alignment: .top) {
            
            Color("redcolor").ignoresSafeArea()
            
            Color("bluecolor").edgesIgnoringSafeArea(.top)
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    
                    if ((Int(currentDateTime.timeIntervalSince1970)+timeZone)%86400<43200) {
                        Text("Good Morning")
                            .font(.largeTitle).foregroundColor(Color.black).padding(.top)
                    } else if ((Int(currentDateTime.timeIntervalSince1970)+timeZone)%86400<61200) {
                        Text("Good Afternoon").font(.largeTitle).foregroundColor(Color.black).padding(.top)
                    } else {
                        Text("Good Evening").font(.largeTitle).foregroundColor(Color.black).padding(.top)
                    }
                    
                    ///////
                    ///
                    
                    if (recommender.recommendedRecipes.isEmpty) {
                        Text("No Suitable Recipes, Please Add More Ingredients to Your Fridge!")
                    }
                    
                    else {
                        

                    
                    ForEach(recommender.recommendedRecipes) { item in
                        
                        
                        NavigationLink(destination: RecipeObjectView(title: item.title, category: item.category, directions: item.directions)) {
                            GroupBox(label: Label(item.title, systemImage: "fork.knife").foregroundColor(.black)) {
                            }
                            .groupBoxStyle(TransparentGroupBox())
                            .padding(.horizontal)
                        }
                        
                        }
                    }
                    
                    ///////
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        
                        GroupBox(label: Label("Breakfast", systemImage: "fork.knife").foregroundColor(.black).font(.largeTitle)) {
                            Text("Breakfast Recommendation")
                                .foregroundColor(Color.black)
                        }
                        .groupBoxStyle(TransparentGroupBox())
                        .padding(.horizontal)
                        GroupBox(label: Label("Lunch", systemImage: "fork.knife").foregroundColor(.black).font(.largeTitle)) {
                            Text("Lunch Recommendation")
                                .foregroundColor(Color.black)
                        }
                        .groupBoxStyle(TransparentGroupBox())
                        .padding(.horizontal)
                        GroupBox(label: Label("Dinner", systemImage: "fork.knife").foregroundColor(.black).font(.largeTitle)) {
                            Text("Dinner Recommendation")
                                .foregroundColor(Color.black)
                        }
                        .groupBoxStyle(TransparentGroupBox())
                        .padding(.horizontal)
                        
                        GroupBox(label: Label("Expiring Ingredients", systemImage: "fork.knife").foregroundColor(.black).font(.largeTitle)) {
                            Text("These ingredients are going to expire")
                                .foregroundColor(Color.black)
                        }
                        .groupBoxStyle(TransparentGroupBox())
                        .padding(.horizontal)
                        
                        
                    }
                    
                }
                
                
            }
            
        }
        
    }
    
    init() {
        recommender.fetchRecipesAndIngredientsFromFirestore()
//        fridgemodel.getData()
    }
    
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
