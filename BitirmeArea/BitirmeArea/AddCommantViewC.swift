import UIKit
import Parse

class YorumYapViewController: UIViewController {

    
    @IBOutlet weak var yorumTextField: UITextField!
    
    @IBOutlet weak var gonderButton: UIButton!
    
    @IBAction func gonderButtonTapped(_ sender: UIButton) {
        // Kullanıcının girdiği metni almak için UITextField'tan değeri alıyoruz
        guard let yorumMetni = yorumTextField.text, !yorumMetni.isEmpty else {
            print("Lütfen bir yorum girin.")
            return
        }

        // Yeni bir PFObject oluşturuyoruz ve yorumMetni değerini atıyoruz
        let parseObject = PFObject(className: "Yorumlar")
        parseObject["placeId"] = "Mekan1" // Örnek bir placeId ataması
        parseObject["yorumMetni"] = yorumMetni // Kullanıcının girdiği yorum metni
        // Diğer gerekli alanlara da istediğiniz değerleri atayabilirsiniz

        parseObject.saveInBackground { (success, error) in
            if let error = error {
                print("Yorum ekleme hatası: \(error.localizedDescription)")
            } else {
                print("Yorum başarıyla eklendi!")
            }
        }
    }
    
  
   /* @IBAction func gonderButtonTapped(_ sender: UIButton) {
        print("Gönder butonuna tıklandı!")
        guard let text = yorumTextField.text, !text.isEmpty else { return }
        guard let placeId = placeId else { return }
        
        let yorum = PFObject(className: "Yorumlar")
        yorum["text"] = text
        yorum["placeId"] = placeId
        
        yorum.saveInBackground { (success, error) in
            if success {
                print("Yorum gönderildi")
                DispatchQueue.main.async {
                    if let yorumlarVC = self.navigationController?.viewControllers.first(where: { $0 is YorumlarViewController }) as? YorumlarViewController {
                        self.navigationController?.popToViewController(yorumlarVC, animated: true)
                    }
                }
            } else if let error = error {
                print("Error sending comment: \(error.localizedDescription)")
            }
        }
    }*/

    var placeId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
