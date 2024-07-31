//
//  SplashSController.swift
//  BitirmeArea
//
//  Created by Sema UĞUR on 22.04.2024.
//

import UIKit

class SplashSController: UIViewController {
    
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    // Label oluştur
    let myLabel = UILabel()
    
    // UIView oluştur
    let circleView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

       
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()   + 2) {

                    self.performSegue(withIdentifier: "OpenMenu", sender: nil)
                }
        
        
        // Arka plan resmini ata
           backgroundImage.image = UIImage(named: "background_image1") //

        // Resmin içeriğini modifiye et
         backgroundImage.contentMode = .scaleAspectFill

        // Resmi ekrana yerleştir
          view.insertSubview(backgroundImage, at: 0)

        
        
        // Çemberin genişliğini ve yüksekliğini ayarla (çember olduğu için aynı olmalı)
        let circleSize: CGFloat = 200
        
        circleView.frame = CGRect(x: 100, y: 230, width: circleSize, height: circleSize)

        // Çemberi yuvarlamak için köşe yarıçapını ayarla (çember olduğu için yarıçap, genişliğin yarısıdır)
        circleView.layer.cornerRadius = circleSize / 2

        // İç rengi (mor) ayarla
        circleView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        // circleView.backgroundColor = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 0.5)


        // Kenar rengini (beyaz) ve kalınlığını (1) ayarla
        circleView.layer.borderColor = UIColor.white.cgColor
        circleView.layer.borderWidth = 1.0

        // View'ı ekrana ekle
        view.addSubview(circleView)
        
        // Yazıyı oluştur
        let text = "AREA"

        // Yazıyı içerecek bir etiket oluştur
        let label = UILabel()
        label.text = text
        //label.textColor = .blue
        label.textColor = UIColor(red: 18/255, green: 49/255, blue: 82/255, alpha: 1.0)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)

        // Yazının boyutunu hesapla
        let textSize = text.size(withAttributes: [.font: label.font as Any])

        // Yazının boyutunu ve konumunu ayarla
        label.frame = CGRect(x: circleView.frame.origin.x + (circleSize - textSize.width) / 2,
                             y: circleView.frame.origin.y + (circleSize - textSize.height) / 2,
                             width: textSize.width,
                             height: textSize.height)

        // View'a etiketi ekle
        view.addSubview(label)
        
        // UILabel oluştur
        let welcomeLabel = UILabel()

        // Metni ayarla
        welcomeLabel.text = "Welcome"
        welcomeLabel.textColor = .white
        // Metin boyutunu ve stilini ayarla
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 24) // Örnek olarak 24 punto büyüklüğünde ve kalın stilini kullanabilirsiniz.

        // Metni merkezlemek için ayarla
        welcomeLabel.textAlignment = .center

        // Arka plan rengini ayarla (opsiyonel)
       // welcomeLabel.backgroundColor = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 0.5)
        welcomeLabel.backgroundColor = UIColor.white.withAlphaComponent(0.5)

        // Kenar rengini (beyaz) ve kalınlığını (1) ayarla
        welcomeLabel.layer.borderColor = UIColor.white.cgColor
        welcomeLabel.layer.borderWidth = 1.0

        // Label'ın boyutunu ayarla
        let labelWidth: CGFloat = 200
        let labelHeight: CGFloat = 50
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
       // welcomeLabel.frame = CGRect(x: (screenWidth - labelWidth) / 2, y: (screenHeight - labelHeight) / 2, width: labelWidth, height: labelHeight)

        welcomeLabel.frame = CGRect(x: 120, y: 600, width: 150, height: 50)
        
        
        
        
        // Kenarları yuvarlamak için köşe yarıçapını ayarla
        welcomeLabel.layer.cornerRadius = 10 // İstediğiniz köşe yarıçapı değerini girin

        // Köşeleri yuvarlamak için özelliği etkinleştir
        welcomeLabel.clipsToBounds = true

        // Label'ı ekrana ekle
        view.addSubview(welcomeLabel)
        
     
    }
    
    


   
    

}
