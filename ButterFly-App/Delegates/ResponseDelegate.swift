//
//  ResponseDelegates.swift
//  ButterFly-App
//
//  Created by Techlocker on 2/10/21.
//

import Foundation

protocol ResponseDelegate{
    //MARK: Calling this protocal to fetch data
    func onResponseDelegate(purchases:[Purchase])
}
