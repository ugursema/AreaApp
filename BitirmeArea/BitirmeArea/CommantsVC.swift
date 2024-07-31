import UIKit
import Parse

class YorumlarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var yorumYapButton: UIButton!
    
    var placeId: String?
    var yorumlar: [CommentsModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getYorumlarFromParse()
        
        
        /*   let  parseObject = PFObject(className: "Yorumlar")
         parseObject["placeId"] = ""
         parseObject.saveInBackground{ (success,  error) in
         if error != nil {
         print(error?.localizedDescription)
         } else{
         print("upload bitti")
         }
         
         }
         
         
         */
        
    }
    
    func getYorumlarFromParse() {
        let query = PFQuery(className: "Yorumlar")
        if let placeId = placeId {
            query.whereKey("placeId", equalTo: placeId)
        }
        query.findObjectsInBackground { (objects, error) in
            if let error = error {
                print("Error retrieving comments: \(error.localizedDescription)")
            } else {
                if let objects = objects {
                    self.yorumlar = objects.map { CommentsModel(object: $0) }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yorumlar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "yorumCell", for: indexPath)
        let yorum = yorumlar[indexPath.row]
        cell.textLabel?.text = yorum.text
        return cell
    }
    
    @IBAction func yorumYapButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showYorumYap", sender: placeId)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showYorumYap" {
            if let destinationVC = segue.destination as? YorumYapViewController {
                destinationVC.placeId = sender as? String
            }
        }
    }
}
