//
//  PurchaseOrder+CoreDataProperties.swift
//  ButterFly-App
//
//  Created by Techlocker on 4/10/21.
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
    @NSManaged public var purchaseItems: NSSet?
    @NSManaged public var purchaseInvoice: NSSet?
    @NSManaged public var purchaseCancellions: NSSet?

}

// MARK: Generated accessors for purchaseItems
extension PurchaseOrder {

    @objc(addPurchaseItemsObject:)
    @NSManaged public func addToPurchaseItems(_ value: PurchaseOrderItem)

    @objc(removePurchaseItemsObject:)
    @NSManaged public func removeFromPurchaseItems(_ value: PurchaseOrderItem)

    @objc(addPurchaseItems:)
    @NSManaged public func addToPurchaseItems(_ values: NSSet)

    @objc(removePurchaseItems:)
    @NSManaged public func removeFromPurchaseItems(_ values: NSSet)

}

// MARK: Generated accessors for purchaseInvoice
extension PurchaseOrder {

    @objc(addPurchaseInvoiceObject:)
    @NSManaged public func addToPurchaseInvoice(_ value: PurchaseOrderInvoice)

    @objc(removePurchaseInvoiceObject:)
    @NSManaged public func removeFromPurchaseInvoice(_ value: PurchaseOrderInvoice)

    @objc(addPurchaseInvoice:)
    @NSManaged public func addToPurchaseInvoice(_ values: NSSet)

    @objc(removePurchaseInvoice:)
    @NSManaged public func removeFromPurchaseInvoice(_ values: NSSet)

}

// MARK: Generated accessors for purchaseCancellions
extension PurchaseOrder {

    @objc(addPurchaseCancellionsObject:)
    @NSManaged public func addToPurchaseCancellions(_ value: PurchaseOrderCancellation)

    @objc(removePurchaseCancellionsObject:)
    @NSManaged public func removeFromPurchaseCancellions(_ value: PurchaseOrderCancellation)

    @objc(addPurchaseCancellions:)
    @NSManaged public func addToPurchaseCancellions(_ values: NSSet)

    @objc(removePurchaseCancellions:)
    @NSManaged public func removeFromPurchaseCancellions(_ values: NSSet)

}

extension PurchaseOrder : Identifiable {

}
