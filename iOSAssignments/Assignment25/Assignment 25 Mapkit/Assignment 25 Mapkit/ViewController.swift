//
//  ViewController.swift
//  Assignment 25 Mapkit
//
//  Created by Waseem Wani on 10/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var citieCoordinatesDict = ["delhi": [28.7041, 77.1025], "kolkata": [22.5726,  88.3639],"hyderabad": [ 17.3850,  78.4867], "ahmedabad" :[ 23.0225 , 72.5714] ]
    
    var annotationPoint = MKPointAnnotation()
    var annotationPoint2 = MKPointAnnotation()
    var annotationPoint3 = MKPointAnnotation()
    var annotationPoint4 = MKPointAnnotation()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for cityname in citieCoordinatesDict
//        {
            annotationPoint.coordinate = CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.1025)
            mapView.addAnnotation(annotationPoint)
            annotationPoint2.coordinate = CLLocationCoordinate2D(latitude: 22.5726, longitude:  88.3639)
            mapView.addAnnotation(annotationPoint2)
            annotationPoint3.coordinate = CLLocationCoordinate2D(latitude: 17.3850, longitude:  78.4867)
            mapView.addAnnotation(annotationPoint3)
        
           annotationPoint4.coordinate = CLLocationCoordinate2D(latitude: 23.0225 , longitude:  72.5714)
           mapView.addAnnotation(annotationPoint4)
        
        let location = CLLocationCoordinate2D( latitude: 28.7041, longitude: 77.1025)
        let location2 = CLLocationCoordinate2D(latitude: 22.5726, longitude: 88.3639)
//        let cirularOverlay = MKCircle(center: location, radius: 10)
        
        
        addCircularOverlay(location)
        addCircularOverlay(location2)
         // var linearray = [28.7041, 77.1025, 22.5726,  88.3639]
        
        //let location2  = CLLocationCoordinate2D( latitude: 17.3850,   longitude: 78.4867)
        //let region = MKCoordinateRegion(//(location, location2)
        //MKCoordinateRegion(center: location, latitudinalMeters: 5000.0, longitudinalMeters: 7000.0)
        //mapView.setRegion(region, animated: true)

        //
    
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if  overlay is MKCircle {
            let circle = MKCircleRenderer.init(overlay: overlay)
            circle.strokeColor = UIColor.blue
            circle.lineWidth = 4.0
            return circle
        }
        return MKCircleRenderer()
    }
    
    func addCircularOverlay(_ location: CLLocationCoordinate2D) {
        //let location = CLLocationCoordinate2D( latitude: 28.7041, longitude: 77.1025)
        let cirularOverlay = MKCircle(center: location, radius: 100)
        mapView.addOverlay(cirularOverlay)
    }
//    annotation.coordinate = (latitude: point["latitude"] as! Double, longitude: point["longitude"] as! Double)
//    mapView.addAnnotation(annotation)
//}
    //28.7041° N, 77.1025°
  //28.7041° N, 77.1025°

}

