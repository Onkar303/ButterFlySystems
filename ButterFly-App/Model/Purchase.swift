//
//  PurchaseOrder.swift
//  ButterFly-App
//
//  Created by Techlocker on 2/10/21.
//

import Foundation


struct Purchase:Codable{
    
    var id:Int
    var supplier_id:Int
    var purchase_order_number:String
    var stock_purchase_process_ids:[Int]
    var issue_date:String
    var items:[Item]
    var invoices:[Invoice]
    var cancellations:[Cancellation]
    var status:Int
    var active_flag:Bool
    var last_updated:String
    var last_updated_user_entity_id:Int
    var sent_date:String
    var server_timestamp:Int
    var device_key:String
    var approval_status:Int
    var preferred_delivery_date:String
    var delivery_note:String
    
}


struct Item:Codable{
    let id:Int
    let product_item_id:Int
    let quantity:Int
    let last_updated_user_entity_id:Int
    let transient_identifier:String
    let active_flag:Bool
    let last_updated:String
    
}

struct Invoice:Codable{
    let id:Int
    let invoice_number:String
    let received_status:Int
    let created:String
    let last_updated_user_entity_id:Int
    let transient_identifier:String
    let receipts:[Receipt]
    let receipt_sent_date:String
    let active_flag:Bool
    let last_updated:String
    
}

struct Receipt:Codable{
    
    let id:Int
    let product_item_id:Int
    let received_quantity:Int
    let created:String
    let last_updated_user_entity_id:Int
    let transient_identifier:String
    let sent_date:String
    let active_flag:Bool
    let last_updated:String
}

struct Cancellation:Codable{
    let id:Int
    let product_item_id:Int
    let ordered_quantity:Int
    let last_updated_user_entity_id:Int
    let created:String
    let transient_identifier:String
}
