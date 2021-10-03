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
    
    var purchaseOrder:Purchase?
    override func viewDidLoad() {
        super.viewDidLoad()
        attachDelegates()
    }
    
    
    //MARK: Attaching Delegates
    func attachDelegates(){
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
    }
    
}


//MARK: Delegate Methods of Details Table View
extension DetailsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == INVOICE_SECTION {
            return (purchaseOrder?.invoices.count)!
        } else if section == ITEM_SECTION {
            return (purchaseOrder?.items.count)!
        } else {
            return (purchaseOrder?.cancellations.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let purchaseOrder = purchaseOrder else {return InvoiceTableViewCell()}
        
        if indexPath.section == INVOICE_SECTION {
            
            let invoiceCell = tableView.dequeueReusableCell(withIdentifier: "invoiceCell", for: indexPath) as! InvoiceTableViewCell
            
            invoiceCell.invoiceNumberLabel.text = "Invoice Number:  \(purchaseOrder.invoices[indexPath.row].invoice_number)"
            invoiceCell.statusLabel.text = "Received Status: \(purchaseOrder.invoices[indexPath.row].received_status)"
            
            return invoiceCell
        } else if indexPath.section ==  ITEM_SECTION {
            
            let itemCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
            
            itemCell.itemIdLabel.text = "Id: \(purchaseOrder.items[indexPath.row].id)"
            itemCell.quantityLabel.text = "Quantity: \(purchaseOrder.items[indexPath.row].quantity)"
            
            return itemCell
        } else {
            
            let cancellationCell = tableView.dequeueReusableCell(withIdentifier: "cancellationCell", for: indexPath) as! CancellationTableViewCell
            
            cancellationCell.cancellationIdLabel.text = "Id: \(purchaseOrder.cancellations[indexPath.row].id)"
            cancellationCell.orderedQuantityLabel.text = "Ordered Quantity: \(purchaseOrder.cancellations[indexPath.row].ordered_quantity)"
            
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
