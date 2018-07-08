//
//  DataManager.swift
//  NoteBoard
//
//  Created by Marcello Mirsal on 08/07/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import CoreData

class DataManager {
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        self.persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func loadStore(completion : (() -> ())? ) {
        persistentContainer.loadPersistentStores { (storeDescrotion, error) in
            if let _ = error {
                fatalError("Fail loading Store")
            }
            completion?()
        }
    }
    
    
}
