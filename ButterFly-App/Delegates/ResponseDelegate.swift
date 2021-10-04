//
//  ResponseDelegates.swift
//  ButterFly-App
//
//  Created by Techlocker on 2/10/21.
//

import Foundation

protocol ApiResponseDelegate{
    //MARK: Calling this protocal to fetch data
    func onApiResponseDelegate(purchases:[Purchase])
}

protocol DatabaseResponseDelegate {
    func onDatabaseResponseDelegate(isCompleted:Bool,purchaseOrders:[PurchaseOrder])
}
