//
//  NetUtils.swift
//  ButterFly-App
//
//  Created by Techlocker on 2/10/21.
//

import Foundation


class NetUtils{
    var responseDelegate:ResponseDelegate?
    
  
    //MARK: Fetching Data from URL
    func fetchData(){
        let url = URL(string: Constants.url)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            
            if let _ = error {return}
            guard let data = data else {return}
            guard let responseDelegate = self.responseDelegate else {return}

            
            do {
                let purchaseOrder = try JSONDecoder().decode([PurchaseOrder].self, from: data)
                responseDelegate.onResponseDelegate(purchases: purchaseOrder)
            } catch {
                print("error")
            }
            
        }.resume()
        
    }
}
