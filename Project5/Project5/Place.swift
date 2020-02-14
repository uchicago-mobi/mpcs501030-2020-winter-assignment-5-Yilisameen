//
//  MapAnnotation.swift
//  Project5
//
//  Created by Yangjun Bie on 2/9/20.
//  Copyright © 2020 Yangjun Bie. All rights reserved.
//

import MapKit
import Foundation

class Place: MKPointAnnotation {
    let name: String?
    let longDescription: String?
    
    init(name: String, description: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.longDescription = description
        super.init()
        self.coordinate = coordinate
    }
}
