//
//  ViewModel.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 4/3/23.
//

import Foundation
import Firebase

class FridgeViewModel: ObservableObject {
    
    // items of all ingredients in user's fridge
    
    @Published var fridge = [Ingredient]()
    
    var categories = ["Select a Category", "Fruits", "Vegetables", "Grains", "Protein", "Dairy", "Condiments", "Other"]
    
    var user = "travtran"
    
    // update data function: will pass in the ingredient name, category, amount, amount unit, and expiration date
    
    func updateData(ingredientToUpdate: Ingredient, ingredient: String, category: String, amount: String, amount_unit: String, expiration: Date) {
        
        // reference to database
        let db = Firestore.firestore()
        
        // update on merge format -- if fields already exist, do not overwrite
        
        db.collection("users").document(user).collection("fridge").document(ingredientToUpdate.id).setData(["ingredient": ingredient, "category": category,"amount": amount,"amount-unit": amount_unit,"expiration": expiration], merge: true) { error in
            
            // update data again by running getData()
            
            if error == nil {
                self.getData()
            }
        }
    }
    
    // function to delete ingredient data from fridge
    
    func deleteData(ingredientToDelete: Ingredient) {
        
        
        // reference to database
        
        let db = Firestore.firestore()
        
        // delete the approriate ingredient by the id
        
        db.collection("users").document(user).collection("fridge").document(ingredientToDelete.id).delete { error in
            
            if error == nil {
                
                // delete by async function, will also update places where the fridge list is displayed
                
                DispatchQueue.main.async {
                    
                    self.fridge.removeAll { ingredient in
                        return ingredient.id == ingredientToDelete.id
                    }
                    
                }

            }
            
        }
    }
    
    // function to add ingredient data
    
    func addData(ingredient: String, category: String, amount: String, amount_unit: String, expiration: Date) {
        
        // get reference
        
        let db = Firestore.firestore()
        
        // add data by fields -- ingredient, category, amount, amount unit, expiration
        
        db.collection("users").document(user).collection("fridge").addDocument(data: ["ingredient": ingredient, "category": category, "amount": amount, "amount-unit": amount_unit, "expiration": expiration]) {
            
            error in
            
            if error == nil {
                
                // if no error, run getData to update everything
                
                self.getData()
            }
            else {
                
            }
        }
        
    }
    
    // function to get fridge ingredient data
    
    func getData() {
        
        // get reference to the database
        
        let db = Firestore.firestore()
        
        // read all documents
        
        db.collection("users").document(user).collection("fridge").getDocuments { snapshot, error in
            
            // check for errors
            
            if error == nil {
                
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        
                        // get all docs and assign them to published variable "fridge" in async format
                        
                        self.fridge = snapshot.documents.map { d
                            
                            // for each ingredient object, declare date -- needs special formatting
                            
                            var date: Date
                            
                            // convert Timestamp object to Date object
                            
                            if let firTimestamp = d["expiration"] as? Timestamp {
                                date = firTimestamp.dateValue()
                                let secondsSinceEpoch = date.timeIntervalSince1970
                            } else {
                                print("firTimestamp is not a FIRTimestamp object")
                                date = Date()
                            }
                            
                            
                            
                            print(d["ingredient"] as? String ?? "")
                            
                            // return each ingredient object
                            
                            return Ingredient(id: d.documentID,
                                        ingredient: d["ingredient"] as? String ?? "",
                                        category: d["category"] as? String ?? "",
                                        amount: d["amount"] as? String ?? "",
                                        amount_unit: d["amount-unit"] as? String ?? "",
                                        expiration: date as? Date ?? Date()
                            )
                        }
                        
                        // sort ingredients in fridge by alphabet
                        
                        self.fridge.sort {
                            $0.ingredient < $1.ingredient
                        }
                        
                    }
                }
                
            } else {
                
            }
        }
    }
    
}
