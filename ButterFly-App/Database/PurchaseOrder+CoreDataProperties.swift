//
//  PurchaseOrder+CoreDataProperties.swift
//  ButterFly-App
//
//  Created by Techlocker on 3/10/21.
//
//

import Foundation
import CoreData


extension PurchaseOrder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PurchaseOrder> {
        return NSFetchRequest<PurchaseOrder>(entityName: "PurchaseOrder")
    }

    @NSManaged public var id: Int64
    @NSManaged public var lastupdated: Date?
    @NSManaged public var numberofitems: Int64
    @NSManaged public var purchaseItems: PurchaseOrderItem?
    @NSManaged public var purchaseCancellions: PurchaseOrderCancellation?
    @NSManaged public var purchaseInvoice: PurchaseOrderInvoice?

}

extension PurchaseOrder : Identifiable {

}
