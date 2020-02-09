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
    
    let coordinate = CLLocationCoordinate2D(latitude: 41.948287,
    longitude: -87.655697)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mapView's delegate
        //mapView.delegate = self
        
        //configure the map view
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        
        //set the current region of the map:
        let span = MKCoordinateSpan(latitudeDelta: 0.008167393319212124, longitudeDelta: 0.00978871051851371)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.region = region
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
