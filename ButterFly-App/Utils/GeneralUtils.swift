//
//  GeneralUtils.swift
//  ButterFly-App
//
//  Created by Techlocker on 4/10/21.
//

import Foundation
import UIKit

class GeneralUtils{
    
    // MARK: Returning an alertController
    static func getAlertController(title:String?,message:String?) -> UIAlertController? {
      
        guard message != nil else {return nil}
        guard title != nil else {return nil}
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(alertAction)
        
        return alertController
    }
    
    
    //MARK: Returning the current date
    static func getCurrentdate() -> Date {
        return Date.now
    }
    
    
    //MARK: Retruning a loading indicator
    //REFERENCE: https://stackoverflow.com/questions/27033466/how-to-display-activity-indicator-in-center-of-uialertcontroller
    static func getLoadingIndicator() -> UIAlertController{
        
        let pending = UIAlertController(title: Constants.loadingIndicatorMessage , message: nil, preferredStyle: .alert)
              //create an activity indicator
        let indicator = UIActivityIndicatorView(frame: pending.view.bounds)
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]

          //add the activity indicator as a subview of the alert controller's view
        pending.view.addSubview(indicator)
        indicator.isUserInteractionEnabled = false // required otherwise if there buttons in the UIAlertController you will not be able to press them
        indicator.startAnimating()
        return pending
    }
    
}
