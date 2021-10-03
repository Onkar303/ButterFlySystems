//
//  AddPurchaseViewController.swift
//  ButterFly-App
//
//  Created by Techlocker on 2/10/21.
//

import UIKit

class AddPurchaseViewController: UIViewController {

    @IBOutlet weak var idLabel: UITextField!
    weak var databaseController:DatabaseController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onAddData(_ sender: Any) {
        let _ = databaseController?.insertPurchase(id: Int(idLabel.text!) ?? 2)
        databaseController?.saveData()
    }
    
    
    @IBAction func onFetchData(_ sender: Any) {
        print(databaseController?.fetchAllPruchases())
    }
    
   
}
