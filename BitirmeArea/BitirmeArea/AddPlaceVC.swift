//
//  AddPlaceVC.swift
//  BitirmeArea
//
//  Created by Sema UĞUR on 19.04.2024.
//
//
import UIKit
import Parse

//var globalName = ""
//var globalType = ""
//var globalDis = ""

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
  
    

    @IBOutlet weak var placeNameText: UITextField!
     
    @IBOutlet weak var placeTypePicker: UIPickerView!
    
     
    @IBOutlet weak var placeDiscText: UITextField!
    @IBOutlet weak var placeimageView: UIImageView!
    
    let placeTypes = ["Yemek", "Kafe", "Restoran", "Diğer"] // Mekan türlerinin listesi
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

     
    override func viewDidLoad() {
        super.viewDidLoad()
 
        placeimageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeimageView.addGestureRecognizer(gestureRecognizer)
        
        placeTypePicker.delegate = self
        placeTypePicker.dataSource = self
        
    } 
   @IBAction func nextButtonClick(_ sender: Any) {
       if placeNameText.text != "" && placeTypePicker.selectedRow(inComponent: 0) != -1 && placeDiscText.text != "" {
             if let choosenImage = placeimageView.image {
                 let placeModel = PlaceModel.sharedInstance
                 placeModel.placeName = placeNameText.text!
                 placeModel.placeType = placeTypes[placeTypePicker.selectedRow(inComponent: 0)] // Seçilen mekan türünü al
                 placeModel.placeDis = placeDiscText.text!
                 placeModel.placeImage = choosenImage
             }
             performSegue(withIdentifier: "toMapVC", sender: nil)
         } else {
             let alert = UIAlertController(title: "Error", message: "Place Name / Type / Description are required!", preferredStyle: UIAlertController.Style.alert)
             let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
             alert.addAction(okButton)
             present(alert, animated: true, completion: nil)
         }
     
   }
    
    @objc func chooseImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeimageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Tek bir sütun kullanacağız
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return placeTypes.count // Mekan türlerinin sayısı kadar satır olacak
    }

 
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return placeTypes[row] // Her satır için uygun mekan türünü döndür
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Kullanıcı bir mekan türü seçtiğinde yapılacak işlemler buraya gelecek
        let selectedPlaceType = placeTypes[row]
        print("Selected place type: \(selectedPlaceType)")
    }

    

}
    
