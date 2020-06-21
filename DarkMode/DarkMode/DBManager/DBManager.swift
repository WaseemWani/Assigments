//
//  DBManager.swift
//  Employees World
//
//  Created by Waseem Wani on 15/05/20.
//  Copyright © 2020 TTN. All rights reserved.


//  Database manager for performing different database operations. Here we create context and perform different database opertaions in that context

import UIKit
import Foundation
import CoreData

enum CoreDataModelType<T> {
    case employeesData
        
    var discriptorKey: String? {
        switch self {
        case .employeesData:
            return "id"
        }
    }
    
    var predicate: Int32? {
        switch self {
        case .employeesData:
            return nil
        }
    }
    
    var resultType : T.Type {
        switch self {
            
        case .employeesData:
            return T.self
        }
    }
}

// this class manages different database operations
class DBManager {
    
    static let sharedInstance = DBManager() //singleton class, shared instance
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DarkMode")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    var appDBContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveData<T>(modelType: CoreDataModelType<T>, completion: @escaping((T) -> Void)) {
        let entityName = String(describing: modelType.resultType)
        let empLocationEntity = NSEntityDescription.insertNewObject(forEntityName: entityName, into: appDBContext) as! T
        let result = (empLocationEntity)
        completion(result)
        saveContext()
    }
    
    func saveContext () {
        if appDBContext.hasChanges {
            do {
                try appDBContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")             }
            //            do {
            //                try? appDBContext.save()
            //            }
            
        }
    }
    
    func retrieveData<T: NSManagedObject>(modelType: CoreDataModelType<T>) -> NSFetchedResultsController<T>? {
        let entity = String(describing: modelType.resultType)
        let fetchRequest = NSFetchRequest<T>(entityName: entity)
        let key = modelType.discriptorKey ?? ""
        if let predicate = modelType.predicate {
            fetchRequest.predicate = NSPredicate(format: "\(key) == \(predicate)")
        }
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: key, ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDBContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController
    }
    
//    func deleteData<T>(modelType: CoreDataModelType<T>) {
//        let entity =  String(describing: modelType.resultType)
//        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//
//        do {
//            _ = try? appDBContext.execute(deleteRequest)
//            try? appDBContext.save()
//        }
//    }
//
//    func getRecordsCount<T: NSManagedObject>(modelType: CoreDataModelType<T>) -> Int {
//        let entity = String(describing: modelType.resultType)
//        let fetchRequest = NSFetchRequest<T>(entityName: entity)
//        let key = modelType.discriptorKey ?? ""
//        if let predicate = modelType.predicate {
//            fetchRequest.predicate = NSPredicate(format: "\(key) == \(predicate)")
//        }
//        do {
//            let count = try? appDBContext.count(for: fetchRequest)
//            return count!
//        }
//    }
}
