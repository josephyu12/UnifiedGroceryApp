//
//  ViewModel.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 4/3/23.
//

import Foundation
import Firebase

class FridgeViewModel: ObservableObject {
    
    @Published var fridge = [Ingredient]()
    
    var user = "travtran"
    
    func updateData(ingredientToUpdate: Ingredient) {
        let db = Firestore.firestore()
        db.collection("users").document(user).collection("fridge").document(ingredientToUpdate.id).setData(["ingredient": "Updated: \(ingredientToUpdate.ingredient)"], merge: true) { error in
            
            if error == nil {
                self.getData()
            }
        }
    }
    
    func deleteData(ingredientToDelete: Ingredient) {
        
        let db = Firestore.firestore()
        
        db.collection("users").document(user).collection("fridge").document(ingredientToDelete.id).delete { error in
            
            if error == nil {
                
                // Update from main thread
                
                DispatchQueue.main.async {
                    
                    self.fridge.removeAll { ingredient in
                        return ingredient.id == ingredientToDelete.id
                    }
                    
                }

            }
            
        }
    }
    
    func addData(ingredient: String, category: String, amount: Float, amount_unit: String) {
        
        // get reference
        let db = Firestore.firestore()
        
        // add document
        db.collection("users").document(user).collection("fridge").addDocument(data: ["ingredient": ingredient, "category": category, "amount": amount, "amount-unit": amount_unit]) {
            error in
            
            if error == nil {
                self.getData()
            }
            else {
                
            }
        }
        
    }
    
    func getData() {
        // get reference to the database
        let db = Firestore.firestore()
        
        // Read the documents
        
        db.collection("users").document(user).collection("fridge").getDocuments { snapshot, error in
            // check for errors
            if error == nil {
                
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        
                        // get all docs and create todos
                        self.fridge = snapshot.documents.map { d in
                            
                            print(d["ingredient"] as? String ?? "")
                            
                            return Ingredient(id: d.documentID,
                                        ingredient: d["ingredient"] as? String ?? "",
                                        category: d["category"] as? String ?? "",
                                        amount: d["directions"] as? Float ?? 0.0,
                                        amount_unit: d["amount-unit"] as? String ?? ""
                            )
                        }
                        
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
