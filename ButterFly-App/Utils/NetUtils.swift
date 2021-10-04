//
//  NetUtils.swift
//  ButterFly-App
//
//  Created by Techlocker on 2/10/21.
//

import Foundation


class NetUtils{
    var responseDelegate:ApiResponseDelegate?
    
  
    //MARK: Fetching Data from URL
    func fetchData(){
        let url = URL(string: Constants.url)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            
            if let _ = error {return}
            guard let data = data else {return}
            guard let responseDelegate = self.responseDelegate else {return}

            
            do {
                let purchaseOrder = try JSONDecoder().decode([Purchase].self, from: data)
                responseDelegate.onApiResponseDelegate(purchases: purchaseOrder)
            } catch {
                print("error")
            }
            
        }.resume()
        
    }
}
