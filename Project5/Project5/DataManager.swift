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
    var arrOfFavorites = [String]()
    
    
    
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
        let defaultFavoritesList = UserDefaults.standard.stringArray(forKey: "name") ?? [String]()
        print(defaultFavoritesList)
        for points in defaultFavoritesList {
            arrOfFavorites.append(points)
            dictionaryOfFavorites[points] = dictionaryOfIntrest[points]
        }
        
    }
    
    func saveFavorites(_ newFavorite: PlaceInformation) {
        dictionaryOfFavorites[newFavorite.name] = newFavorite
        arrOfFavorites.append(newFavorite.name)
        UserDefaults.standard.set(arrOfFavorites, forKey: "name")
    }
    
    func deleteFavorite(_ name: String) {
        dictionaryOfFavorites[name] = nil
        let index = arrOfFavorites.firstIndex(of: name)
        arrOfFavorites.remove(at: index!)
        UserDefaults.standard.set(arrOfFavorites, forKey: "name")
    }
    
}
