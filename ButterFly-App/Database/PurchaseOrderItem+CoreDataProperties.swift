//
//  PurchaseOrderItem+CoreDataProperties.swift
//  ButterFly-App
//
//  Created by Techlocker on 3/10/21.
//
//

import Foundation
import CoreData


extension PurchaseOrderItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PurchaseOrderItem> {
        return NSFetchRequest<PurchaseOrderItem>(entityName: "PurchaseOrderItem")
    }

    @NSManaged public var id: Int64
    @NSManaged public var quantity: Int64
    @NSManaged public var purchaseOrder: PurchaseOrder?

}

extension PurchaseOrderItem : Identifiable {

}
