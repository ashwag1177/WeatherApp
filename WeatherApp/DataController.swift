//
//  DataController.swift
//  WeatherApp
//
//  Created by  ashwaq marzouq on 15/12/1444 AH.
//

import CoreData

class DataController {
    static let shared = DataController(modelName: "Weather")
    
    let persistantContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistantContainer.viewContext
    }
    
    init(modelName:String) {
        persistantContainer = NSPersistentContainer(name: modelName)
    }
    
    var backgroundContext:NSManagedObjectContext!
    
    
    func configureViewContext() {
        backgroundContext = persistantContainer.newBackgroundContext()
        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
    }
    
    
    func load(completion: (() -> Void)? = nil) {
        persistantContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            self.configureViewContext()
            self.autoSaveViewContext()
            completion?()
        }
        
        
    }
    
    func deleteCity(city: City) {
        persistantContainer.viewContext.delete(city)
        autoSaveViewContext()
    }
    
        
}



extension DataController {
    func autoSaveViewContext(interval:TimeInterval = 30) {
        guard interval > 0 else {
            print("error saving")
            return
        }
        
        if viewContext.hasChanges {
            try? viewContext.save()
        }
        DispatchQueue.main.async {
            self.autoSaveViewContext(interval: interval)
        }
        
    }
}
