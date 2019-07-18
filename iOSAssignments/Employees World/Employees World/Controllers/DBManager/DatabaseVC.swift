//
//  DatabaseVC.swift
//  Employees World
//
//  Created by Waseem Wani on 31/05/19.
//  Copyright © 2019 TTN. All rights reserved.


//  Database manager for performing database operations. Here we create context and perform different database opertaions in that context

import UIKit
import Foundation
import CoreData

enum CoreDataModelType<T> {
    
    case empLocationModel
    case emplocationById(Int32)
    case selectedImages
    case selectedImagesById(Int32)
    
    var discriptorKey: String? {
        switch self {
        case .empLocationModel, .emplocationById, .selectedImages, .selectedImagesById:
            return "empId"
            //        default:
            //        return nil
        }
    }
    
    var predicate: Int32? {
        switch self {
        case .selectedImagesById(let empId), .emplocationById(let empId):
            return empId
        default:
            return nil
        }
    }
    
    var resultType : T.Type {
        switch self {
            
        case .empLocationModel:
            return T.self
        default:
            return T.self
        }
    }
}

// this class manages different database operations
class DBManager {
    
    static let sharedInstance = DBManager() //singleton class
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Employees_World")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    var appDBContext: NSManagedObjectContext {
        //        let context = appDelegate?.persistentContainer.viewContext
        return persistentContainer.viewContext
    }
    
    func saveData<T>(modelType: CoreDataModelType<T>, completion: @escaping((T) -> Void)) {
        
        //        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return }
        //        let context = appDelegate.persistentContainer.viewContext
        let entityName = String(describing: modelType.resultType)
        print("entity name", entityName)
        let empLocationEntity = NSEntityDescription.insertNewObject(forEntityName: entityName, into: appDBContext) as! T
        print("\(empLocationEntity)")
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
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)") //This is not allowed in release build, as it will crash app
            }
//            do {
//                try? appDBContext.save()
//            }

        }
    }
    
    func retrieveData<T: NSManagedObject>(modelType: CoreDataModelType<T>) -> NSFetchedResultsController<T>? {
        
         print(modelType.resultType)
        let entity = String(describing: modelType.resultType)
        let fetchRequest = NSFetchRequest<T>(entityName: entity)
        // guard let fetchRequest = modelType.resultType.fetchRequest() as? NSFetchRequest<T> else { return nil }
        let key = modelType.discriptorKey ?? ""
        //print(modelType.predicate)
        if let predicate = modelType.predicate {
            print(predicate)
            print("\(key)")//as? Int32 
            fetchRequest.predicate = NSPredicate(format: "\(key) == \(predicate)")
        }
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: key, ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDBContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController //as! NSFetchedResultsController<T>
    }
    
    func deleteData<T>(modelType: CoreDataModelType<T>) {
        //        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let entity =  String(describing: modelType.resultType)
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            _ = try? appDBContext.execute(deleteRequest)
            try? appDBContext.save()
        }
    }
    
    func getRecordsCount<T: NSManagedObject>(modelType: CoreDataModelType<T>) -> Int {
        let entity = String(describing: modelType.resultType)
        let fetchRequest = NSFetchRequest<T>(entityName: entity)
        let key = modelType.discriptorKey ?? ""
        if let predicate = modelType.predicate {
            fetchRequest.predicate = NSPredicate(format: "\(key) == \(predicate)")
        }
        do {
            let count = try? appDBContext.count(for: fetchRequest)
            //print(count)
            return count!
          }
        }
    
    }

//    func retreiveData() -> NSFetchedResultsController<EmpLocation> {
//
//            let fetchRequest:NSFetchRequest = EmpLocation.fetchRequest()
//                        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "empId", ascending: true)]
//                        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDBContext, sectionNameKeyPath: nil, cacheName: nil)
//        //fetchResultController.delegate = self as? NSFetchedResultsControllerDelegate
//                        try? fetchResultController.performFetch()
//                        return fetchResultController
//        }


    //    class func saveEmpLocation(_ empId: Int, _ lat: Double, _ long: Double, _ locName1: String, _ locName2: String) {
    //        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    //        let context = appDelegate.persistentContainer.viewContext
    //        let empLocationEntity = NSEntityDescription.insertNewObject(forEntityName: "EmpLocation", into: context) as! EmpLocation
    //        empLocationEntity.empId = Int32(empId)
    //        empLocationEntity.latitude = lat
    //        empLocationEntity.longitude = long
    //        empLocationEntity.address1 = locName1
    //        empLocationEntity.address2 = locName2
    //
    //        if context.hasChanges {
    //            do {
    //                try context.save()
    //            } catch {
    //                print("An error occurred while saving: \(error)")
    //            }
    //        }
    //    }
    

