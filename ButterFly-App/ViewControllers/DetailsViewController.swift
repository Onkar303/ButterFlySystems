//
//  DetailsViewController.swift
//  ButterFly-App
//
//  Created by Techlocker on 2/10/21.
//

import Foundation
import UIKit


class DetailsViewController:UIViewController
{
    @IBOutlet weak var detailsTableView: UITableView!
    let INVOICE_SECTION = 0
    let ITEM_SECTION = 1
    let CANCELLATION_SECTION = 2
    
    var purchaseOrder:PurchaseOrder?
    var databaseUpdateDelegate:DatabaseUpdatedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attachDelegates()
        configureUI()
    }
    
    
    //MARK: Attaching Delegates
    func attachDelegates(){
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
    }
    
    func configureUI(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Item", style:.plain , target: self, action: #selector(presentAddItemViewController))
    
    }
    
    
    @objc func presentAddItemViewController(){
        let addItemStoryBoard = UIStoryboard(name: "AddItemStoryBoard", bundle: .main)
        let addItemViewController = addItemStoryBoard.instantiateViewController(withIdentifier: "addItemViewController") as! AddItemViewController
        

        addItemViewController.purchaseOrder = purchaseOrder
        addItemViewController.databaseUpdatedDelegate = self
        
        present(addItemViewController, animated: true, completion: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        databaseUpdateDelegate?.onDatabaseUpdated()
        
    }
    
}


//MARK: Delegate Methods of Details Table View
extension DetailsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == INVOICE_SECTION {
            return (purchaseOrder?.purchaseInvoice!.count)!
        } else if section == ITEM_SECTION {
            return (purchaseOrder?.purchaseItems!.count)!
        } else {
            return (purchaseOrder?.purchaseCancellions!.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let purchaseOrder = purchaseOrder else {return InvoiceTableViewCell()}
        
       
        if indexPath.section == INVOICE_SECTION {
            
            let invoiceCell = tableView.dequeueReusableCell(withIdentifier: "invoiceCell", for: indexPath) as! InvoiceTableViewCell
            let invoice = purchaseOrder.purchaseInvoice?.allObjects as! [PurchaseOrderInvoice]
            invoiceCell.invoiceNumberLabel.text = "Invoice Number:  \( invoice[indexPath.row].id )"
            invoiceCell.statusLabel.text = "Received Status: \(invoice[indexPath.row].receivedstatus)"
            
            return invoiceCell
        } else if indexPath.section ==  ITEM_SECTION {
            
            let itemCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
            let items = purchaseOrder.purchaseItems?.allObjects as! [PurchaseOrderItem]
            itemCell.itemIdLabel.text = "Id: \(items[indexPath.row].id)"
            itemCell.quantityLabel.text = "Quantity: \(items[indexPath.row].quantity)"
            
            return itemCell
        } else {
            
            let cancellationCell = tableView.dequeueReusableCell(withIdentifier: "cancellationCell", for: indexPath) as! CancellationTableViewCell
//            let cancellation = purchaseOrder.purchaseItems?.allObjects as [PurchaseOrderCancellation]
//            cancellationCell.cancellationIdLabel.text = "Id: \(cancellation[indexPath.row].id)"
//            cancellationCell.orderedQuantityLabel.text = "Ordered Quantity: \(cancellation[indexPath.row].orderedquantity)"
            return cancellationCell
        }
    
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == INVOICE_SECTION {
            return "Invoice"
        } else if section == ITEM_SECTION {
            return "Items"
        } else {
            return "Cancellations"
        }
        
    }
    
}

extension DetailsViewController:DatabaseUpdatedDelegate {
    func onDatabaseUpdated() {
        DispatchQueue.main.async {
            self.detailsTableView.reloadData()
        }
    }
}
