//
//  PurchaseOrderCancellation+CoreDataProperties.swift
//  ButterFly-App
//
//  Created by Techlocker on 3/10/21.
//
//

import Foundation
import CoreData


extension PurchaseOrderCancellation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PurchaseOrderCancellation> {
        return NSFetchRequest<PurchaseOrderCancellation>(entityName: "PurchaseOrderCancellation")
    }

    @NSManaged public var id: Int64
    @NSManaged public var orderedquantity: Int64
    @NSManaged public var purchaseOrder: PurchaseOrder?

}

extension PurchaseOrderCancellation : Identifiable {

}
