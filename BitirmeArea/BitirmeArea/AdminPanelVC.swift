//
//  AdminPanelVC.swift
//  BitirmeArea
//
//  Created by Sema UĞUR on 6.06.2024.
//
/*
import UIKit

class AdminPanelVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var places: [PlaceModel] = [] // PlaceModel dizisi olarak değiştirildi
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchPlaces()
    }
    
    func fetchPlaces() {
        // Mekanları getiren bir fonksiyon
        // Örneğin, bir PlaceManager kullanabilirsiniz
        PlaceManager.shared.fetchPlaces { (places, error) in
            if let error = error {
                print("Error fetching places: \(error.localizedDescription)")
            } else if let places = places {
                self.places = places
                self.tableView.reloadData()
            }
        }
    }
}

extension AdminPanelVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
        let place = places[indexPath.row]
        cell.textLabel?.text = place.placeName // PlaceModel'den placeName özelliğini kullan
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Mekanı seçtiğinizde yapılacak işlemler
        let selectedPlace = places[indexPath.row]
        // Örneğin, mekanı düzenlemek için başka bir ekrana yönlendirebilirsiniz
        // veya mekanı silme işlemi için bir onay iletişim kutusu gösterebilirsiniz
    }
}
*/
