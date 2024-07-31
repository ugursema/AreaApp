//
//  PlaceManager.swift
//  BitirmeArea
//
//  Created by Sema UĞUR on 6.06.2024.
//


/*

import Foundation
import Parse

class PlaceManager {
    
    static let shared = PlaceManager()
    
    private init() {}
    
    func fetchPlaces(completion: @escaping ([PlaceModel]?, Error?) -> Void) {
        let query = PFQuery(className: "Place")
        query.findObjectsInBackground { (objects, error) in
            if let error = error {
                completion(nil, error)
            } else if let objects = objects {
                let places = objects.map { (object) -> PlaceModel in
                    let place = PlaceModel()
                    place.placeName = object["name"] as? String ?? ""
                    place.placeType = object["type"] as? String ?? ""
                    // Diğer özellikleri de buradan alabilirsiniz
                    return place
                }
                completion(places, nil)
            } else {
                let error = NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
                completion(nil, error)
            }
        }
    }
}
*/
