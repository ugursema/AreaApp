
//
//  MapVC.swift
//  BitirmeArea
//
//  Created by Sema UĞUR on 19.04.2024.
//

import UIKit
import MapKit
import CoreLocation
import Parse

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // Konum izinlerini iste
        locationManager.startUpdatingLocation()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style:UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        
        
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style:UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer: )))
        recognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(recognizer)
        
        
    }
    
    
    @objc func chooseLocation(gestureRecognizer: UIGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizer.State.began{
            
            let touches = gestureRecognizer.location(in: self.mapView)
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            
            self.mapView.addAnnotation(annotation)
            
            PlaceModel.sharedInstance.placeLatitude = String(coordinates.latitude)
            PlaceModel.sharedInstance.placeLongitude = String(coordinates.longitude)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude )
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            // Kullanıcı konum izinlerini verdi, burada gerekli işlemleri yapabilirsiniz.
            print("Kullanıcı konum izinlerini verdi.")
            // Örneğin, konum güncellemelerini almaya başlayabilirsiniz:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            // Kullanıcı konum izinlerini vermedi, uygun bir şekilde yanıt verin.
            print("Kullanıcı konum izinlerini vermedi.")
        case .notDetermined:
            // Konum izinleri henüz belirlenmedi.
            print("Konum izinleri henüz belirlenmedi.")
        default:
            break
        }
    }
    
    @objc func saveButtonClicked() {
        //PARSE
             
             let placeModel = PlaceModel.sharedInstance
             
             let object = PFObject(className: "Places")
             object["name"] = placeModel.placeName
             object["type"] = placeModel.placeType
        object["discription"] = placeModel.placeDis
             object["latitude"] = placeModel.placeLatitude
             object["longitude"] = placeModel.placeLongitude
             
             if let imageData = placeModel.placeImage.jpegData(compressionQuality: 0.5) {
                 object["image"] = PFFileObject(name: "image.jpg", data: imageData)
             }
             
             object.saveInBackground { (success, error) in
                 if error != nil {
                     let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                     let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                     alert.addAction(okButton)
                     self.present(alert, animated: true, completion:nil)
                 } else {
                     self.performSegue(withIdentifier: "fromMapVCtoPlacesVC", sender: nil)
                 }
             }
             
         }
        

    
    
    
    @objc func backButtonClicked(){
       
        
            self.dismiss(animated: true, completion: nil)
        }

        
    }
 
