//
//  PurchaseOrderInvoice+CoreDataProperties.swift
//  ButterFly-App
//
//  Created by Techlocker on 4/10/21.
//
//

import Foundation
import CoreData


extension PurchaseOrderInvoice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PurchaseOrderInvoice> {
        return NSFetchRequest<PurchaseOrderInvoice>(entityName: "PurchaseOrderInvoice")
    }

    @NSManaged public var id: Int64
    @NSManaged public var receivedstatus: Int64
    @NSManaged public var purchaseOrder: PurchaseOrder?

}

extension PurchaseOrderInvoice : Identifiable {

}
