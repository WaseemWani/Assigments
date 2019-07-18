//
//  MapVC.swift
//  Employees World
//
//  Created by Waseem Wani on 01/07/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapVC: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    
    var willDropAnnotations = false
    var empId = Int()
    var isMapVC = true
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view Did load")
        print(UserDefaults.standard.bool(forKey: "isloggedIn"))
        map.delegate = self

        //        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
               // print()
//                print("url:\(url)")
//        print(willDropAnnotations)
        //        if willDropAnnotations == false {
        //        }
    }
    
    // retreieve annotations from database...
    override func viewWillAppear(_ animated: Bool) {
        
        print("empid",empId)
        print("view will appear")
        //        DBManager.sharedInstance.deleteData()
        if (willDropAnnotations == false &&  isMapVC == true) {
            let fetchedResultController =
                DBManager.sharedInstance.retrieveData(modelType: CoreDataModelType<EmpLocation>.empLocationModel)!
            try? fetchedResultController.performFetch()
            
            for emp in (fetchedResultController.fetchedObjects)! {
                //print(emp.address1, emp.empId, emp.latitude, emp.longitude)
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: emp.latitude, longitude: emp.longitude)
                annotation.title = emp.address1
                annotation.subtitle = emp.address2
                map.addAnnotation(annotation)
            }
        }
    }
    
    //add annottaions on long press
    @IBAction func addAnotationOnLongpress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        
        if willDropAnnotations == true {
            dropAnnotatoions(gestureRecognizer)
        }
    }
    
    func dropAnnotatoions(_ gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: map)
            let coordinates = map.convert(touchPoint, toCoordinateFrom: map)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = "my annotation"
            annotation.subtitle = ""
            let locatioName = CLGeocoder()
            locatioName.reverseGeocodeLocation(CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude), completionHandler: {
                placeMarks, error -> Void in self.getPlacemarks(placeMarks, error, annotation) })
            map.addAnnotation(annotation)
            print(annotation.coordinate.latitude)
        }
    }
    
    // this function will give location details from coordinates like country, city, street etc.
    func getPlacemarks(_ placeMarks: [CLPlacemark]?, _ error: Error?, _ annotation: MKPointAnnotation) {
        print(annotation.coordinate.latitude, annotation.coordinate.longitude)
        guard let placeMark = placeMarks?.first else { return }
        if let locationName = placeMark.locality {
            annotation.title = locationName
            print("location Name " + "\(locationName)")
        }
        // Street address
        if let street = placeMark.thoroughfare {
            annotation.subtitle = street
            print("street" + "\(street)")
        }
        // City
        if let city = placeMark.subAdministrativeArea {
            annotation.subtitle?.append(" " + city)
            print("city" + "\(city)")
        }
        // Zip code
        if let zip = placeMark.isoCountryCode {
            print("zip" + "\(zip)")
        }
        // Country
        if let country = placeMark.country {
            annotation.subtitle?.append(" " + country)
            print("country" + "\(country)")
            let dateAdded = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let convertedDate = dateFormatter.string(from: dateAdded)
            annotation.subtitle?.append(" Added on \(convertedDate)")
            print(annotation.subtitle!)
        }
        //print("fulltitle",annotation.title, annotation.subtitle)
        saveEmpLocation(self.empId, annotation.coordinate.latitude, annotation.coordinate.longitude, annotation.title ?? "", annotation.subtitle ?? "")
    }
}

// save the location of each employee along with other details like location name etc.
func saveEmpLocation(_ empId: Int, _ lat: Double, _ long: Double, _ locName1: String, _ locName2: String) {
    
    DBManager.sharedInstance.saveData(modelType: CoreDataModelType<EmpLocation>.empLocationModel) { (result) in
        result.address1 = locName1
        result.address2 = locName2
        result.empId = Int32(empId)
        result.latitude = lat
        result.longitude = long
        //print(result)
    }
}

extension MapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "My Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
}

//        fileprivate lazy var fetchedResultController: NSFetchedResultsController<EmpLocation> = {
//            let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
//            //let context = appDelegate?.persistentContainer.viewContext
//            let fetchRequest:NSFetchRequest = EmpLocation.fetchRequest()
//
//            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "empId", ascending: true)]
//    
//            let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
//    
//            fetchResultController.delegate = self
//
//            try? fetchResultController.performFetch()
//            return fetchResultController
//        }()



extension MapVC: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //        try?
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //        tableView.endUpdates()
    }
}


//    func showAnnotations() {
//        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
//        let managedContext = appdelegate.persistentContainer.viewContext
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EmpLocation")
//        do {
//            let result = try? managedContext.fetch(fetchRequest)
//            for data in result as! [NSManagedObject] {
//                print(data.value(forKey: "empId"))
//
//            }
//        }
//    }

//        func getData() {
//            guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
//            do {
//                let result: EmpLocation = try context.fetch(EmpLocation.fetchRequest() as! NSFetchRequest<NSFetchRequestResult>)
//                print(result)
//                for empLocation in result {
//                    print(empLocation)
//                }
//            } catch {
//                print("Fetching Failed")
//            }
//        }


//        let container = NSPersistentContainer(name: "EmpLocation")
//        container.loadPersistentStores { storeDescription, error in
//            if let error = error {
//                print("Unresolved error \(error)")
//            } else {
//                storeDescription.
//            }

//let entity =  NSEntityDescription.entity(forEntityName: "EmpLocation", in: context)
//        var context = appDelegate?.persistentContainer.managedObjectModel
//        contextt.

//    @objc func dropAnnotation(gestureRecognizer: UIGestureRecognizer) {
//        if gestureRecognizer.state == UIGestureRecognizer.State.began {
//            let touchPoint = gestureRecognizer.location(in: map)
//            let newCoordinates = map.convert(touchPoint, toCoordinateFrom: map)
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = newCoordinates
//            map.addAnnotation(annotation)
//    }
//    }


