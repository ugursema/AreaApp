import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsNameLabel: UILabel!
    @IBOutlet weak var detailsTypeLabel: UILabel!
    @IBOutlet weak var detailsDisLabel: UILabel!
    @IBOutlet weak var detailsMapView: MKMapView!

    
    var chosenPlaceId = ""
    var chosenLatitude = Double()
    var chosenLongitude = Double()

    override func viewDidLoad() {
        super.viewDidLoad()

        detailsMapView.delegate = self
        getDataFromParse()  // getDataFromParse çağrılıyor
    }


    func getDataFromParse() {
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceId)
        query.findObjectsInBackground { (objects, error) in
            if let error = error {
                print("Error retrieving place details: \(error.localizedDescription)")
            } else {
                if let place = objects?.first {
                    self.updateUI(with: place)
                }
            }
        }
    }

    func updateUI(with place: PFObject) {
        if let placeName = place.object(forKey: "name") as? String {
            detailsNameLabel.text = placeName
        }
        if let placeType = place.object(forKey: "type") as? String {
            detailsTypeLabel.text = placeType
        }
        if let placeDis = place.object(forKey: "discription") as? String {
            detailsDisLabel.text = placeDis
        }
        if let placeLatitude = place.object(forKey: "latitude") as? String, let latitude = Double(placeLatitude) {
            self.chosenLatitude = latitude
        }
        if let placeLongitude = place.object(forKey: "longitude") as? String, let longitude = Double(placeLongitude) {
            self.chosenLongitude = longitude
        }
        if let imageData = place.object(forKey: "image") as? PFFileObject {
            imageData.getDataInBackground { (data, error) in
                if let data = data, let image = UIImage(data: data) {
                    self.detailsImageView.image = image
                }
            }
        }
        
        // Update map
        let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: location, span: span)
        self.detailsMapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = detailsNameLabel.text
        annotation.subtitle = detailsTypeLabel.text
        self.detailsMapView.addAnnotation(annotation)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.chosenLongitude != 0.0 && self.chosenLatitude != 0.0 {
            let requestLocation = CLLocation(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                if let placemark = placemarks {
                    
                    if placemark.count > 0 {
                        
                        let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        mapItem.name = self.detailsNameLabel.text
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                        
                        mapItem.openInMaps(launchOptions: launchOptions)
                    }
                    
                }
            }
            
        }
    }

}



/*
 
import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsNameLabel: UILabel!
    @IBOutlet weak var detailsTypeLabel: UILabel!
    @IBOutlet weak var detailsDisLabel: UILabel!
    @IBOutlet weak var detailsMapView: MKMapView!
    
  
 
    @IBOutlet weak var reviewButton: UIButton!
    
    
    var chosenPlaceId = ""
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsMapView.delegate = self
        getDataFromParse()
    }
    
    @IBAction func reviewButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showYorumlar", sender: chosenPlaceId)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showYorumlar" {
            if let destinationVC = segue.destination as? YorumlarViewController {
                destinationVC.placeId = sender as? String
            }
        }
    }
    
    
    func getDataFromParse() {
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceId)
        query.findObjectsInBackground { (objects, error) in
            if let error = error {
                print("Error retrieving place details: \(error.localizedDescription)")
            } else {
                if let place = objects?.first {
                    self.updateUI(with: place)
                }
            }
        }
    }
    
    func updateUI(with place: PFObject) {
        if let placeName = place.object(forKey: "name") as? String {
            detailsNameLabel.text = placeName
        }
        if let placeType = place.object(forKey: "type") as? String {
            detailsTypeLabel.text = placeType
        }
        if let placeDis = place.object(forKey: "discription") as? String {
            detailsDisLabel.text = placeDis
        }
        if let placeLatitude = place.object(forKey: "latitude") as? String, let latitude = Double(placeLatitude) {
            self.chosenLatitude = latitude
        }
        if let placeLongitude = place.object(forKey: "longitude") as? String, let longitude = Double(placeLongitude) {
            self.chosenLongitude = longitude
        }
        if let imageData = place.object(forKey: "image") as? PFFileObject {
            imageData.getDataInBackground { (data, error) in
                if let data = data, let image = UIImage(data: data) {
                    self.detailsImageView.image = image
                }
            }
        }
        
        // Update map
        let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: location, span: span)
        self.detailsMapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = detailsNameLabel.text
        annotation.subtitle = detailsTypeLabel.text
        self.detailsMapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.chosenLongitude != 0.0 && self.chosenLatitude != 0.0 {
            let requestLocation = CLLocation(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                if let placemark = placemarks {
                    
                    if placemark.count > 0 {
                        
                        let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        mapItem.name = self.detailsNameLabel.text
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                        
                        mapItem.openInMaps(launchOptions: launchOptions)
                    }
                    
                }
            }
            
        }
    }

}
*/
