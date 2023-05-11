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
                                          ingredient02: d["ingredient02"] as? String ?? "",
                                          ingredient03: d["ingredient03"] as? String ?? "",
                                          ingredient04: d["ingredient04"] as? String ?? "",
                                          ingredient05: d["ingredient05"] as? String ?? "",
                                          ingredient06: d["ingredient06"] as? String ?? "",
                                          ingredient07: d["ingredient07"] as? String ?? "",
                                          ingredient08: d["ingredient08"] as? String ?? "",
                                          ingredient09: d["ingredient09"] as? String ?? "",
                                          ingredient10: d["ingredient10"] as? String ?? "",
                                          ingredient11: d["ingredient11"] as? String ?? "",
                                          ingredient12: d["ingredient12"] as? String ?? "",
                                          ingredient13: d["ingredient13"] as? String ?? "",
                                          ingredient14: d["ingredient14"] as? String ?? "",
                                          ingredient15: d["ingredient15"] as? String ?? "",
                                          ingredient16: d["ingredient16"] as? String ?? "",
                                          ingredient17: d["ingredient17"] as? String ?? "",
                                          ingredient18: d["ingredient18"] as? String ?? "",
                                          ingredient19: d["ingredient19"] as? String ?? "",
                                          unit01: d["unit01"] as? String ?? "",
                                          unit02: d["unit02"] as? String ?? "",
                                          unit03: d["unit03"] as? String ?? "",
                                          unit04: d["unit04"] as? String ?? "",
                                          unit05: d["unit05"] as? String ?? "",
                                          unit06: d["unit06"] as? String ?? "",
                                          unit07: d["unit07"] as? String ?? "",
                                          unit08: d["unit08"] as? String ?? "",
                                          unit09: d["unit09"] as? String ?? "",
                                          unit10: d["unit10"] as? String ?? "",
                                          unit11: d["unit11"] as? String ?? "",
                                          unit12: d["unit12"] as? String ?? "",
                                          unit13: d["unit13"] as? String ?? "",
                                          unit14: d["unit14"] as? String ?? "",
                                          unit15: d["unit15"] as? String ?? "",
                                          unit16: d["unit16"] as? String ?? "",
                                          unit17: d["unit17"] as? String ?? "",
                                          unit18: d["unit18"] as? String ?? "",
                                          unit19: d["unit19"] as? String ?? "",
                                          qty01: d["qty01"] as? String ?? "",
                                          qty02: d["qty02"] as? String ?? "",
                                          qty03: d["qty03"] as? String ?? "",
                                          qty04: d["qty04"] as? String ?? "",
                                          qty05: d["qty05"] as? String ?? "",
                                          qty06: d["qty06"] as? String ?? "",
                                          qty07: d["qty07"] as? String ?? "",
                                          qty08: d["qty08"] as? String ?? "",
                                          qty09: d["qty09"] as? String ?? "",
                                          qty10: d["qty10"] as? String ?? "",
                                          qty11: d["qty11"] as? String ?? "",
                                          qty12: d["qty12"] as? String ?? "",
                                          qty13: d["qty13"] as? String ?? "",
                                          qty14: d["qty14"] as? String ?? "",
                                          qty15: d["qty15"] as? String ?? "",
                                          qty16: d["qty16"] as? String ?? "",
                                          qty17: d["qty17"] as? String ?? "",
                                          qty18: d["qty18"] as? String ?? "",
                                          qty19: d["qty19"] as? String ?? ""
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
