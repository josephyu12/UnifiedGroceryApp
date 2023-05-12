//
//  ViewModel.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 4/3/23.
//

import Foundation
import Firebase
import NaturalLanguage

class RecommenderViewModel: ObservableObject {
    
    // published variables of recommendedRecipes and expiringIngredients
    
    @Published var recommendedRecipes = [Recipe]()
    
    @Published var expiringIngredients = [Ingredient]()
    
    var categories = ["Select a Category", "Fruits", "Vegetables", "Grains", "Protein", "Dairy", "Condiments", "Other"]
    
    var user = "travtran"
    
    // function to check if a string is singular. Useful for ingredient comparisons later
    
    func singularForm(of pluralWord: String) -> String {
        
        // Check if the word is already singular
        
        if pluralWord.suffix(1) != "s" {
            return pluralWord
        }
        
        // Check for irregular plurals
        
        switch pluralWord {
        case "children":
            return "child"
        case "people":
            return "person"
        case "geese":
            return "goose"
        case "teeth":
            return "tooth"
        case "feet":
            return "foot"
        default:
            break
        }
        
        // Remove the "s" from the end of the word
        
        let singular = String(pluralWord.dropLast())
        
        
        // return the word without s if it's not irregular
        
        return singular
    }
    
    // function that takes in an ingredient object and checks if its expiration date is less than a week from today. Appends all relevant ingredients to a list that is returned
    
    func checkExpiration(ingredients: [Ingredient]) -> [Ingredient] {
        let now = Date()
        let oneWeekFromNow = Calendar.current.date(byAdding: .day, value: 7, to: now)!
        var aboutToExpire: [Ingredient] = []
        
        for ingredient in ingredients {

            if ingredient.expiration <= oneWeekFromNow {
                aboutToExpire.append(ingredient)
            }
        }
        
        return aboutToExpire
    }

    // function to check for a list of recipes if any of the recipes contain relevant ingredients. This will loop through all recipes and add it to a validRecipes array if it is missing less than 3 ingredients
    
    func checkIngredients(for recipes: [Recipe], using ingredients: [Ingredient]) -> [Recipe] {
        
        var validRecipes: [Recipe] = []
        
        // loop through each recipes
        
        for recipe in recipes {
            print("---------")
            
            var missingIngredients: [String] = []
            
            // get all ingredients for the recipe in a list
            
            let totalIngredients = [
                    recipe.ingredient01,
                    recipe.ingredient02,
                    recipe.ingredient03,
                    recipe.ingredient04,
                    recipe.ingredient05,
                    recipe.ingredient06,
                    recipe.ingredient07,
                    recipe.ingredient08,
                    recipe.ingredient09,
                    recipe.ingredient10,
                    recipe.ingredient11,
                    recipe.ingredient12,
                    recipe.ingredient13,
                    recipe.ingredient14,
                    recipe.ingredient15,
                    recipe.ingredient16,
                    recipe.ingredient17,
                    recipe.ingredient18,
                    recipe.ingredient19
                ]
            
            print(totalIngredients)
            
            // loop through each ingredient in the recipe. See if it exists in the fridge ingredient list
            
            for ingredientName in totalIngredients {
                
                // assume everyone has water, ignore if the ingredient is water
                
                if (ingredientName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == "water") {
                    continue
                }
                
                // ignore if the ingredient is blank (filler space)
                
                if (ingredientName.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
                    
                    print(singularForm(of: (ingredientName.trimmingCharacters(in: .whitespacesAndNewlines))))
                    
                    // trim both the strings and lowercase them, and see if the fridge ingredient has the recipe ingredient as a substring
                    
                    if ingredients.contains(where: { singularForm(of: ($0.ingredient.lowercased())).contains(singularForm(of: (ingredientName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()))) }) {
                        
                        // continue, essentially
                        
                        // if missing ingredient, append it to an array of missing ingredients
                        
                    } else {
                        missingIngredients.append(ingredientName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())
                    }
                    
                    
                }
                
            }
            
            // if there are less than 3 missing ingredients for this recipe, consider it valid
            
            if missingIngredients.count <= 2 {
                validRecipes.append(recipe)
            }
            
        }
        
        return validRecipes
    }
    
    // get all recipes and ingredients from Firestore database, using dispatch control for the async functions
    
    func fetchRecipesAndIngredientsFromFirestore() {
        
        // get references to ingredients and recipes locations
        
        let db = Firestore.firestore()
        let recipesRef = db.collection("recipes-v2")
        let ingredientsRef = db.collection("users").document(user).collection("fridge")
        
        // define the recipes and ingredients variables that returns from the database will be added to
        
        var recipes: [Recipe] = []
        var ingredients: [Ingredient] = []
        let dispatchGroup = DispatchGroup()
        
        // start a dispatchGroup for async function
        
        dispatchGroup.enter()
        
        // get all recipes
        
        recipesRef.getDocuments { (querySnapshot, error) in
            
            // if there is an error, exit
            
            if let error = error {
                print("Error fetching recipes: \(error.localizedDescription)")
                dispatchGroup.leave()
                return
            }
            
            // make sure querySnapshot exists, else exit
            
            guard let querySnapshot = querySnapshot else {
                dispatchGroup.leave()
                return
            }
            
            // let recipes be a map for each of the returned recipes, with this relevant field information
            
            recipes = querySnapshot.documents.compactMap { document -> Recipe? in
                let data = document.data()
                let id = document.documentID
                let title = data["title"] as? String ?? ""
                let category = data["category"] as? String ?? ""
                let directions = data["directions"] as? String ?? ""
                let ingredient01 = data["ingredient01"] as? String ?? ""
                let ingredient02 = data["ingredient02"] as? String ?? ""
                let ingredient03 = data["ingredient03"] as? String ?? ""
                let ingredient04 = data["ingredient04"] as? String ?? ""
                let ingredient05 = data["ingredient05"] as? String ?? ""
                let ingredient06 = data["ingredient06"] as? String ?? ""
                let ingredient07 = data["ingredient07"] as? String ?? ""
                let ingredient08 = data["ingredient08"] as? String ?? ""
                let ingredient09 = data["ingredient09"] as? String ?? ""
                let ingredient10 = data["ingredient10"] as? String ?? ""
                let ingredient11 = data["ingredient11"] as? String ?? ""
                let ingredient12 = data["ingredient12"] as? String ?? ""
                let ingredient13 = data["ingredient13"] as? String ?? ""
                let ingredient14 = data["ingredient14"] as? String ?? ""
                let ingredient15 = data["ingredient15"] as? String ?? ""
                let ingredient16 = data["ingredient16"] as? String ?? ""
                let ingredient17 = data["ingredient17"] as? String ?? ""
                let ingredient18 = data["ingredient18"] as? String ?? ""
                let ingredient19 = data["ingredient19"] as? String ?? ""
                let unit01 = data["unit01"] as? String ?? ""
                let unit02 = data["unit02"] as? String ?? ""
                let unit03 = data["unit03"] as? String ?? ""
                let unit04 = data["unit04"] as? String ?? ""
                let unit05 = data["unit05"] as? String ?? ""
                let unit06 = data["unit06"] as? String ?? ""
                let unit07 = data["unit07"] as? String ?? ""
                let unit08 = data["unit08"] as? String ?? ""
                let unit09 = data["unit09"] as? String ?? ""
                let unit10 = data["unit10"] as? String ?? ""
                let unit11 = data["unit11"] as? String ?? ""
                let unit12 = data["unit12"] as? String ?? ""
                let unit13 = data["unit13"] as? String ?? ""
                let unit14 = data["unit14"] as? String ?? ""
                let unit15 = data["unit15"] as? String ?? ""
                let unit16 = data["unit16"] as? String ?? ""
                let unit17 = data["unit17"] as? String ?? ""
                let unit18 = data["unit18"] as? String ?? ""
                let unit19 = data["unit19"] as? String ?? ""
                let qty01 = data["qty01"] as? String ?? ""
                let qty02 = data["qty02"] as? String ?? ""
                let qty03 = data["qty03"] as? String ?? ""
                let qty04 = data["qty04"] as? String ?? ""
                let qty05 = data["qty05"] as? String ?? ""
                let qty06 = data["qty06"] as? String ?? ""
                let qty07 = data["qty07"] as? String ?? ""
                let qty08 = data["qty08"] as? String ?? ""
                let qty09 = data["qty09"] as? String ?? ""
                let qty10 = data["qty10"] as? String ?? ""
                let qty11 = data["qty11"] as? String ?? ""
                let qty12 = data["qty12"] as? String ?? ""
                let qty13 = data["qty13"] as? String ?? ""
                let qty14 = data["qty14"] as? String ?? ""
                let qty15 = data["qty15"] as? String ?? ""
                let qty16 = data["qty16"] as? String ?? ""
                let qty17 = data["qty17"] as? String ?? ""
                let qty18 = data["qty18"] as? String ?? ""
                let qty19 = data["qty19"] as? String ?? ""
                
                // return the recipe object for each of the returned recipes
                
                let recipe = Recipe(
                    id: id,
                    title: title,
                    category: category,
                    directions: directions,
                    ingredient01: ingredient01,
                    ingredient02: ingredient02,
                    ingredient03: ingredient03,
                    ingredient04: ingredient04,
                    ingredient05: ingredient05,
                    ingredient06: ingredient06,
                    ingredient07: ingredient07,
                    ingredient08: ingredient08,
                    ingredient09: ingredient09,
                    ingredient10: ingredient10,
                    ingredient11: ingredient11,
                    ingredient12: ingredient12,
                    ingredient13: ingredient13,
                    ingredient14: ingredient14,
                    ingredient15: ingredient15,
                    ingredient16: ingredient16,
                    ingredient17: ingredient17,
                    ingredient18: ingredient18,
                    ingredient19: ingredient19,
                    unit01: unit01,
                    unit02: unit02,
                    unit03: unit03,
                    unit04: unit04,
                    unit05: unit05,
                    unit06: unit06,
                    unit07: unit07,
                    unit08: unit08,
                    unit09: unit09,
                    unit10: unit10,
                    unit11: unit11,
                    unit12: unit12,
                    unit13: unit13,
                    unit14: unit14,
                    unit15: unit15,
                    unit16: unit16,
                    unit17: unit17,
                    unit18: unit18,
                    unit19: unit19,
                    qty01: qty01,
                    qty02: qty02,
                    qty03: qty03,
                    qty04: qty04,
                    qty05: qty05,
                    qty06: qty06,
                    qty07: qty07,
                    qty08: qty08,
                    qty09: qty09,
                    qty10: qty10,
                    qty11: qty11,
                    qty12: qty12,
                    qty13: qty13,
                    qty14: qty14,
                    qty15: qty15,
                    qty16: qty16,
                    qty17: qty17,
                    qty18: qty18,
                    qty19: qty19
                )
                return recipe
            }
            dispatchGroup.leave()
        }
        
        // start a new dispatchGroup as getting the ingredients now
        
        dispatchGroup.enter()
        
        
        ingredientsRef.getDocuments { (querySnapshot, error) in
            
            // if there is error, leave
            
            if let error = error {
                print("Error fetching ingredients: \(error.localizedDescription)")
                dispatchGroup.leave()
                return
            }
            
            // make sure querySnapshot exists or leave
            
            guard let querySnapshot = querySnapshot else {
                dispatchGroup.leave()
                return
            }
            
            // go through all of the returned ingredients with a compactMap
            
            ingredients = querySnapshot.documents.compactMap { document -> Ingredient? in
                
                let data = document.data()
                
                // define date, will need special formatting
                
                var date: Date
                
                // convert the returned expiration to a Date object from Timestamp
                
                if let firTimestamp = data["expiration"] as? Timestamp {
                    date = firTimestamp.dateValue()
                    let secondsSinceEpoch = date.timeIntervalSince1970
                } else {
                    print("firTimestamp is not a FIRTimestamp object")
                    date = Date()
                }
                
                // assign the fields to the correct information
                
                let id = document.documentID
                let ingredient = data["ingredient"] as? String ?? ""
                let category = data["category"] as? String ?? ""
                let amount = data["amount"] as? String ?? ""
                let amount_unit = data["amount_unit"] as? String ?? ""
                let expiration = date as? Date ?? Date()
                
                let ingredient_return = Ingredient(id: id, ingredient: ingredient, category: category, amount: amount, amount_unit: amount_unit, expiration: expiration)
                return ingredient_return
            }
            
            // finish ingredients collection
            
            dispatchGroup.leave()
        }
        
        // run the two functions and assign them to the public variables, recommendedRecipes and expiringIngredients
        
        dispatchGroup.notify(queue: .main) {
            self.recommendedRecipes = self.checkIngredients(for: recipes, using: ingredients)
            self.expiringIngredients = self.checkExpiration(ingredients: ingredients)
        }
    }
        
}
