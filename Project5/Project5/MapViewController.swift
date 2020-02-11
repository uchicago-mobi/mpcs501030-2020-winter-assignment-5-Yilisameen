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
    @IBOutlet var displayView: UIView!
    
    var arrayOfAnnotations = [MKAnnotation]()
    let coordinate = CLLocationCoordinate2D(latitude: 41.948287,
    longitude: -87.655697)
    let span = MKCoordinateSpan(latitudeDelta: 0.00978871051851371, longitudeDelta: 0.008167393319212124)
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Request authorization and
        // set the view controller as the location manager's delegate
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        //mapView's delegate
        mapView.delegate = self
        
        //configure the map view
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll

        
        //read places from Data.plist and add annotations to mapView
        DataManager.sharedInstance.loadAnnotationFromPlist()
        
        for place in DataManager.sharedInstance.dictionaryOfIntrest.values {
            //let coordinates = place.coordinate
            let annotation = Place(name: place.name, description: place.description, coordinate: place.coordinate)
            mapView.addAnnotation(annotation)
            arrayOfAnnotations.append(annotation)
        }
        mapView.showAnnotations(arrayOfAnnotations, animated: true)
        
        favoriteStar.addTarget(self, action: #selector(addFavorites), for: .touchUpInside)
        
        self.view.sendSubviewToBack(displayView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func addFavorites(_ button: UIButton) {
        if favoriteStar.isSelected {
            DataManager.sharedInstance.deleteFavorite(annotationName.text!)
            favoriteStar.isSelected = false
        }
        else{
            let newFavorite: PlaceInformation = DataManager.sharedInstance.dictionaryOfIntrest[annotationName.text!]!
            DataManager.sharedInstance.saveFavorites(newFavorite)
            favoriteStar.isSelected = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToFavorites" {
            let controller = segue.destination as! FavoritesViewController
            controller.delegate = self
        }
    }

}

//Delegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.view.bringSubviewToFront(displayView)
        let annotation = view.annotation as? Place
        annotationName.text = annotation?.name
        annotationDescription.text = annotation?.longDescription
        favoriteStar.isSelected = DataManager.sharedInstance.dictionaryOfFavorites[(annotation?.name)!] != nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("Tapped a callout")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Place {
            let identifier = "CustomPin"
            
            var view: PlaceMarkerView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? PlaceMarkerView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = PlaceMarkerView(annotation: annotation, reuseIdentifier: identifier)
            }
            return view
        }
        return nil
    }
    
}

extension MapViewController: PlaceFavoritesDelegate {
    func favoritePlace(name: String) {
        let favoritePoint = DataManager.sharedInstance.dictionaryOfIntrest[name]
        let region = MKCoordinateRegion(center: favoritePoint!.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        annotationName.text = favoritePoint?.name
        annotationDescription.text = favoritePoint?.description
        favoriteStar.isSelected = true
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Authorized!")
        case .notDetermined:
            print("We need to request authorization")
        default:
            print("Not authorized :(")
        }
    }
}

