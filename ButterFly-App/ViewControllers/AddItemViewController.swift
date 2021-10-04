//
//  AddItemViewController.swift
//  ButterFly-App
//
//  Created by Techlocker on 2/10/21.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    var purchaseOrder:PurchaseOrder?
    var databaseController:DatabaseController?
    var databaseUpdatedDelegate:DatabaseUpdatedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getDatabaseController()
    }
    
    
    func getDatabaseController(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
    }
    

    @IBAction func onAddItem(_ sender: Any) {
        
        
        guard let id = idTextField.text,!id.isEmpty else {
            presentError()
            return
            
        }
        guard let quantity = quantityTextField.text,!quantity.isEmpty else {
            presentError()
            return
        }
        
        guard let item = databaseController?.insertItem(id: Int(id), quantityOrdered: Int(quantity)) else {return}
        purchaseOrder?.addToPurchaseItems(item)
        purchaseOrder?.numberofitems = Int64((purchaseOrder?.purchaseItems!.count)!)
        purchaseOrder?.lastupdated = GeneralUtils.getCurrentdate()
        
        databaseController?.saveData()
        
        databaseUpdatedDelegate?.onDatabaseUpdated()
        dismiss(animated: true, completion: nil)
    }
    
    func presentError(){
        present(GeneralUtils.getAlertController(title: "Error", message: "Please Enter all Fields")!, animated:
                    true, completion: nil)
        
    }
    
}
