//
//  CurrencyLayer.swift
//  Currency Converter
//
//  Created by Mayank Kumar on 7/28/15.
//  Copyright (c) 2015 Mayank Kumar. All rights reserved.
//

import Foundation

class CurrencyLayer {
    
    func requestCurrencyQuotes(_ completionHandler: @escaping (_ success: Bool, _ quotes: [String:AnyObject]?, _ error: String?) -> Void) {
        if Reachability.isConnectedToNetwork() {
            let urlString = "http://apilayer.net/api/live?access_key=bcd58c132d287dc4b443f5e1f3eb59e1&currencies=EUR,GBP,INR&format=1"
            let session = URLSession.shared
            let url = URL(string: urlString)!
            
            let request = URLRequest(url: url)
            let task = session.dataTask(with: request, completionHandler: { data, response, error in
                if error != nil {
                    completionHandler(false, nil, error!.localizedDescription)
                }
                else {
                    do {
                        let result = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                            if let dictionary = result["quotes"] as? [String:AnyObject]! {
                                completionHandler(true, dictionary, nil)
                            }
                            else {
                                completionHandler(false, nil, nil)
                            }
                    } catch {
                        completionHandler(false, nil, "Unable to process retrieved data.")
                    }
                }
                    
            }) 
            task.resume()
        }
        else {
            completionHandler(false, nil, "Please check you internet connection and try again.")
        }
    }
}
