//
//  AddPurchaseViewController.swift
//  ButterFly-App
//
//  Created by Techlocker on 2/10/21.
//

import UIKit

class AddPurchaseViewController: UIViewController {

    @IBOutlet weak var idLabel: UITextField!
    @IBOutlet weak var invoiceIdTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    weak var databaseController:DatabaseController?
    var onDatabaseUpdated:DatabaseUpdatedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onAddData(_ sender: Any) {
        
        guard let id = idLabel.text,!id.isEmpty else {
            presentError()
            return
        }
        guard let invoidId = invoiceIdTextField.text,!invoidId.isEmpty else {
            presentError()
            return
            
        }
        guard let status = statusTextField.text,!status.isEmpty else {
            presentError()
            return
            
        }
        
        let purchaseOrder = databaseController?.insertPurchase(id: Int(id))
        purchaseOrder?.addToPurchaseInvoice((databaseController?.insertInvoice(id: Int(invoidId), status: Int(status)))!)
        
        databaseController?.saveData()
        onDatabaseUpdated?.onDatabaseUpdated()
        dismiss(animated: true)
    }
    
    
    @IBAction func onFetchData(_ sender: Any) {
        print(databaseController?.fetchAllPruchases())
    }
        
    
    func presentError(){
        present(GeneralUtils.getAlertController(title: "Error", message: "Please Enter all Fields")!, animated:
                    true, completion: nil)
        
    }
   
}
