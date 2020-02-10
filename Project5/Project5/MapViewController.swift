//
//  MapViewController.swift
//  Project5
//
//  Created by Yangjun Bie on 2/9/20.
//  Copyright © 2020 Yangjun Bie. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var annotationName: UILabel!
    @IBOutlet var annotationDescription: UILabel!
    @IBOutlet var favoriteStar: UIButton!
    
    let coordinate = CLLocationCoordinate2D(latitude: 41.948287,
    longitude: -87.655697)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mapView's delegate
        mapView.delegate = self
        
        //configure the map view
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        
        //set the current region of the map:
        let span = MKCoordinateSpan(latitudeDelta: 0.008167393319212124, longitudeDelta: 0.00978871051851371)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.region = region
        
        //read places from Data.plist and add annotations to mapView
        let path = Bundle.main.path(forResource: "Data", ofType: "plist")!
        let dict = NSDictionary(contentsOfFile: path)
        let places = dict!.object(forKey: "places") as! [Dictionary<String, AnyObject>]
        for place in places {
            let coordinates = CLLocationCoordinate2DMake(place["lat"]! as! CLLocationDegrees, place["long"]! as! CLLocationDegrees)
            let annotation = Place(name: place["name"]! as! String, description: place["description"]! as! String, coordinate: coordinates)
            mapView.addAnnotation(annotation)
            mapView.showAnnotations([annotation], animated: true)
        }
    }
    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        let annotation = view.annotation as? Place
//        print(annotation?.name as Any)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//Delegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation as? Place
        //print(annotation?.longDescription as Any)
        annotationName.text = annotation?.name
        annotationDescription.text = annotation?.longDescription
        //print(annotation?.description as Any)
        favoriteStar.isSelected = true
    }
}

