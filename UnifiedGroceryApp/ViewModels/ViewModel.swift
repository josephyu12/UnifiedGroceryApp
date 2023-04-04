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
                            
                            print(d["title"] as? String ?? "")
                            
                            return Recipe(id: d.documentID,
                                        title: d["title"] as? String ?? "",
                                        category: d["category"] as? String ?? "",
                                        directions: d["directions"] as? String ?? "",
                                        ingredient01: d["ingredient01"] as? String ?? "",
                                        unit01: d["unit01"] as? String ?? "",
                                        qty01: d["qty01"] as? Float ?? 0.0
                                        )
                        }
                        
                    }
                }
                
            } else {
                
            }
        }
    }
    
}
