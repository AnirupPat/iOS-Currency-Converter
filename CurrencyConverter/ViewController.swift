//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Anirup Patnaik on 25/10/19.
//  Copyright © 2019 Virtuelabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var yenLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=c7989f9318c540241532b35786b23bb2")!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            else {
                if data != nil {
                    do {
                        let jsonResponse =  try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        // ASYNC
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                if let yen = rates["JPY"] as? Double {
                                    self.yenLabel.text = "YEN: \(yen)"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                if let tryVal = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(tryVal)"
                                }
                            }
                        }
                    }
                    catch {
                        print("Error!")
                    }
                    
                }
            }
        }
        task.resume()
    }
    
}

