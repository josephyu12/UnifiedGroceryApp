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
//style for box grouping
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
    // pulls recipes
    @ObservedObject var fridgemodel = FridgeViewModel()
    //setup for time, data, group box view
    let timeZone = Int(TimeZone.current.secondsFromGMT())
    let currentDateTime = Date()
    let data = (1...100).map { "Item \($0)" }
    let columns = [
        GridItem(.flexible())
    ]
    
    var categories = ["Appetizers", "Main Dishes", "Salads", "Soup", "Desserts"]
    
    @ObservedObject var recommender = RecommenderViewModel()
    
    var body: some View {
        // for navigation links
        NavigationView {
            
            ZStack (alignment: .top) {
                
                Color("redcolor").ignoresSafeArea()
                
                Color("bluecolor").edgesIgnoringSafeArea(.top)
                
                ScrollView(showsIndicators: false) {
                    
                    VStack {
                        //sets time of day message
                        if ((Int(currentDateTime.timeIntervalSince1970)+timeZone)%86400<43200) {
                            Text("Good Morning")
                                .font(.largeTitle).foregroundColor(Color.black).padding(.top)
                        } else if ((Int(currentDateTime.timeIntervalSince1970)+timeZone)%86400<61200) {
                            Text("Good Afternoon").font(.largeTitle).foregroundColor(Color.black).padding(.top)
                        } else {
                            Text("Good Evening").font(.largeTitle).foregroundColor(Color.black).padding(.top)
                        }
                        
                        Text("Your Personalized Recipe Recommendations:").font(.headline).foregroundColor(Color.black).padding(.top, -10.0)
                        
                        // if no ingredients, show nothing
                        
                        if (recommender.recommendedRecipes.isEmpty) {
                            
                        }
                        // else show recommendations
                        else {
                            //loops thorugh categories
                            ForEach(categories, id:\.self) { category in
                                
                                let subRecipes = recommender.recommendedRecipes.filter {$0.category == category}
                                
                                if (subRecipes.isEmpty) {
                                    
                                } else {
                                    
                                    
                                    GroupBox(label: HStack {
                                        Spacer()
                                        Label(category, systemImage: "").padding(.bottom, -5.0).padding(.top, 5.0).foregroundColor(.black).font(.largeTitle)
                                        Spacer()
                                    }) {
                                        
                                        
                                        ForEach(subRecipes) { item in
                                            //loops through recommendations and fields in them
                                            NavigationLink(destination: RecipeObjectView(title: item.title, category: item.category, directions: item.directions)) {
                                                GroupBox(label: Label(item.title, systemImage: "fork.knife").foregroundColor(.black)) {
                                                }
                                                .groupBoxStyle(TransparentGroupBox())
                                                .padding(.horizontal)
                                                
                                            }
                                            
                                        }
                                    }
                                    
                                    .groupBoxStyle(TransparentGroupBox())
                                    .padding(.horizontal)
                                    
                                }
                            }
                            // displays ingredients that are about to expire
                            LazyVGrid(columns: columns, spacing: 20) {
                                
                                GroupBox(label: HStack {
                                    Spacer()
                                    Label("Expiring Ingredients", systemImage: "exclamationmark.triangle").padding(.top).foregroundColor(.black).font(.title)
                                    Spacer()
                                }
                                ) {
                                    // loops thorugh ingredients
                                    ForEach(recommender.expiringIngredients) { item in
                                        GroupBox(label: Label(item.ingredient, systemImage: "fork.knife").foregroundColor(.black)) {
                                            
                                            
                                            HStack {
                                                Text("Expiration Date:")
                                                    .foregroundColor(Color.black)
                                                Text(item.expiration, style: .date)
                                                    .foregroundColor(Color.black)
                                                
                                            }
                                            .padding(.top, -5.0)
                                            
                                            
                                            
                                        }
                                        .groupBoxStyle(TransparentGroupBox())
                                        .padding(.horizontal)
                                    }
                                    
                                }
                                .groupBoxStyle(TransparentGroupBox())
                                .padding(.horizontal)
                                
                                
                            }
                        }
                        
                    }
                    
                    Spacer()
                    //makes page refreshable
                }.refreshable {recommender.fetchRecipesAndIngredientsFromFirestore()}
                
            }
            
        }
    }
    //pulls from firebase
    init() {
        recommender.fetchRecipesAndIngredientsFromFirestore()
    }
    
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
