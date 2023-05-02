//
//  ViewModel.swift
//  UnifiedGroceryApp
//
//  Created by Joseph Yu on 4/3/23.
//

import Foundation
import Firebase

class ViewModel: ObservableObject {
    
    @Published var list = [Recipe]()
    
    func updateData(recipeToUpdate: Recipe) {
        let db = Firestore.firestore()
        db.collection("recipes").document(recipeToUpdate.id).setData(["title": "Updated: \(recipeToUpdate.title)"], merge: true) { error in
            
            if error == nil {
                self.getData()
            }
        }
    }
    
    func deleteData(recipeToDelete: Recipe) {
        
        let db = Firestore.firestore()
        
        db.collection("recipes").document(recipeToDelete.id).delete { error in
            
            if error == nil {
                
                // Update from main thread
                
                DispatchQueue.main.async {
                    
                    self.list.removeAll { recipe in
                        return recipe.id == recipeToDelete.id
                    }
                    
                }

            }
            
        }
    }
    
    func addData(title: String, category: String) {
        
        // get reference
        let db = Firestore.firestore()
        
        // add document
        db.collection("recipes").addDocument(data: ["title": title, "category": category]) {
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
        
        db.collection("recipes").getDocuments { snapshot, error in
            // check for errors
            if error == nil {
                
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        
                        // get all docs and create todos
                        self.list = snapshot.documents.map { d in
                            
//                            print(d["title"] as? String ?? "")
                            
                            return Recipe(id: d.documentID,
                                        title: d["title"] as? String ?? "",
                                        category: d["category"] as? String ?? "",
                                        directions: d["directions"] as? String ?? "",
                                        ingredient01: d["ingredient01"] as? String ?? "",
                                        unit01: d["unit01"] as? String ?? "",
                                        qty01: d["qty01"] as? Float ?? 0.0
                            )
                        }
                        
                        self.list.sort {
                            $0.title < $1.title
                        }
                        
                        
                    }
                }
                
            } else {
                
            }
        }
    }
    
}
