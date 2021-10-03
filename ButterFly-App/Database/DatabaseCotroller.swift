//
//  DatabaseCotroller.swift
//  ButterFly-App
//
//  Created by Techlocker on 2/10/21.
//

import Foundation
import CoreData
import UIKit


class DatabaseController:NSObject{
    
    var persistanceContainer:NSPersistentContainer
    var netUtils = NetUtils()
    var apiPurchase = [Purchase]()
    
    

    override init() {
        persistanceContainer = NSPersistentContainer(name: "ButterFlySystems-Database")
        persistanceContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Data \(error)")
            }
        }
        
        super.init()
        attachDelegate()
        
      
    }
    
    
    //MARK: Attaching Delegates
    func attachDelegate(){
        netUtils.responseDelegate = self
        if fetchAllPruchases().isEmpty {
            //netUtils.fetchData()
        }
    }
    
    // MARK: Saving Data
    func saveData(){
        if persistanceContainer.viewContext.hasChanges{
            do{
                try persistanceContainer.viewContext.save()
            }catch{
                print("Error saving data")
            }
        }
    }
    
    
    //MARK: Inserting Purchase Order
    func insertPurchase(id:Int?) -> PurchaseOrder{
        
        guard let id = id else { return PurchaseOrder()}
        
        let purchase = NSEntityDescription.insertNewObject(forEntityName: "PurchaseOrder", into: persistanceContainer.viewContext) as! PurchaseOrder
        purchase.id = Int64(id)
        purchase.lastupdated = GeneralUtils.getCurrentdate()
      
            //purchase.purchaseItems = insertItem(id: <#T##Int?#>, quantityOrdered: <#T##Int?#>)
        return purchase
    }
    
    
    // MARK: Inserting Purchase Order Item
    func insertItem(id:Int?,quantityOrdered:Int?)-> PurchaseOrderItem? {
        guard let id = id else { return nil}
        guard let quantityOrdered = quantityOrdered else {return nil}
        
        
        let item = NSEntityDescription.insertNewObject(forEntityName: "PurchaseOrderItem", into: persistanceContainer.viewContext) as! PurchaseOrderItem
        item.id = Int64(id)
        item.quantity = Int64(quantityOrdered)
        
        return item
    }
    
    
    //MARK: Inserting Purchase Order Invoice
    func insertInvoice(id:Int?,status:Int?) -> PurchaseOrderInvoice? {
        
        guard let id = id else {return nil}
        guard let status = status else {return nil}
        
        let invoice = NSEntityDescription.insertNewObject(forEntityName: "PurchaseOrderInvoice", into: persistanceContainer.viewContext) as! PurchaseOrderInvoice
        
        invoice.id = Int64(id)
        invoice.receivedstatus = Int64(status)
        
        
        return invoice
        
        
    }
    
    
    //MARK: Fetching All Purchases
    func fetchAllPruchases() -> [PurchaseOrder]{
        let fetchRequest = PurchaseOrder.fetchRequest()
        let purchase = [PurchaseOrder]()
        do{
            let result =  try persistanceContainer.viewContext.fetch(fetchRequest) as [PurchaseOrder]
            return result
        }catch {
            print("Unable to fetch Results")
        }
        return purchase
    }
    
}


extension DatabaseController:ResponseDelegate{
    
    func onResponseDelegate(purchases: [Purchase]) {
        apiPurchase.removeAll()
        apiPurchase.append(contentsOf: purchases)
    }
    
    
}
