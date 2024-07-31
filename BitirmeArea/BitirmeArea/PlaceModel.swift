//
//  PlaceModel.swift
//  BitirmeArea
//
//  Created by Sema UĞUR on 22.04.2024.
//

import Foundation
import UIKit


class PlaceModel{
    
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeDis = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    var placeId = ""
    
    
    
   private init(){}
    // public init() {}
}
