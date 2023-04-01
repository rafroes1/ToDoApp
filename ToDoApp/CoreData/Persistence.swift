//
//  Persistence.swift
//  ToDoApp
//
//  Created by Rafael Carvalho on 31/03/23.
//

import CoreData
import Foundation

class PersistenceController: ObservableObject {
    let container = NSPersistentContainer(name: "ToDoApp")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Cora data failed to load: \(error.localizedDescription)")
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
