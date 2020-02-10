//
//  DataManager.swift
//  Project5
//
//  Created by Yangjun Bie on 2/9/20.
//  Copyright © 2020 Yangjun Bie. All rights reserved.
//

import Foundation
import MapKit

struct PlaceInformation {
    var name: String
    var description: String
    var coordinate: CLLocationCoordinate2D
    
    init(_ _name: String,
         _ _description: String, _ _coordinate: CLLocationCoordinate2D) {
        name = _name;
        description = _description
        coordinate = _coordinate
    }
}

public class DataManager {
    public static let sharedInstance = DataManager()
    
    var dictionaryOfIntrest = [String: PlaceInformation]()
    var dictionaryOfFavorites = [String: PlaceInformation]()
    //var arrOfIntrest = [PlaceInformation]()
    var arrOfFavorites = [PlaceInformation]()
    
    fileprivate init() {}
    
    func loadAnnotationFromPlist() {
        let path = Bundle.main.path(forResource: "Data", ofType: "plist")!
        let dict = NSDictionary(contentsOfFile: path)
        let places = dict!.object(forKey: "places") as! [Dictionary<String, AnyObject>]
        for place in places {
            let placeName: String = place["name"]! as! String
            let placeDescription = place["description"]! as! String
            let placeCoordinate = CLLocationCoordinate2DMake(place["lat"]! as! CLLocationDegrees, place["long"]! as! CLLocationDegrees)
            let intrestPoint = PlaceInformation(placeName, placeDescription, placeCoordinate)
            dictionaryOfIntrest[intrestPoint.name] = intrestPoint
            //arrOfIntrest.append(intrestPoint)
        }
        
    }
    
    func saveFavorites(_ newFavorite: PlaceInformation) {
        dictionaryOfFavorites[newFavorite.name] = newFavorite
        arrOfFavorites.append(newFavorite)
    }
    
    func deleteFavorite(_ name: String) {
        dictionaryOfFavorites[name] = nil
        for i in 0..<arrOfFavorites.count-1 {
            if arrOfFavorites[i].name == name {
                arrOfFavorites.remove(at: i)
            }
        }
    }
    
}
