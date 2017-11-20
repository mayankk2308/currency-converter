//
//  ViewController.swift
//  Currency Converter
//
//  Created by Mayank Kumar on 7/28/15.
//  Copyright (c) 2015 Mayank Kumar. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController {

    @IBOutlet var refresh: UIButton!
    @IBOutlet var activityindicator: UIActivityIndicatorView!
    @IBOutlet var usdInputLabel: UILabel!
    @IBOutlet var eurOutputLabel: UILabel!
    @IBOutlet var gbpOutputLabel: UILabel!
    @IBOutlet var inrOutputLabel: UILabel!
    var quotes: [String:AnyObject]!
    var decimalDisabled = false
    var enableConversion = false
    var defaults = {
       return UserDefaults.standard
    }()
    
    
    override func viewDidLoad() {
        makeCurrencyQuoteRequest()
        activityindicator.startAnimating()
        refresh.isEnabled = false
    }
    
    func displayAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func makeCurrencyQuoteRequest() {
        CurrencyLayer().requestCurrencyQuotes() { success, newQuotes, error in
            if success {
                self.quotes = newQuotes
                
                self.removeAllKeysForUserDefaults()
                DispatchQueue.main.async {
                    self.stopActivityIndicator()
                    self.refresh.isEnabled = true
                }
                
                //Persist quotes using NSUserDefaults
                self.saveQuotesToUserDefaults(self.quotes["USDEUR"] as! Float, key: "EUR")
                self.saveQuotesToUserDefaults(self.quotes["USDGBP"] as! Float, key: "GBP")
                self.saveQuotesToUserDefaults(self.quotes["USDINR"] as! Float, key: "INR")
            }
            else {
                DispatchQueue.main.async {
                    self.displayAlert("Unable to Retrieve Latest Conversion Rates", message: "\(error!) Until then, last used conversion rates apply if available, or else conversion rates will default to rates on July 27, 2015.")
                    self.stopActivityIndicator()
                    self.refresh.isEnabled = true
                }
                self.quotes = [
                    "USDEUR": self.accessQuotesFromUserDefaults("EUR") as AnyObject,
                    "USDGBP": self.accessQuotesFromUserDefaults("GBP") as AnyObject,
                    "USDINR": self.accessQuotesFromUserDefaults("INR") as AnyObject
                ]
            }
            self.enableConversion = true
        }
    }
    
    func stopActivityIndicator() {
        self.activityindicator.stopAnimating()
        self.activityindicator.isHidden = true
    }
    
    func saveQuotesToUserDefaults(_ value: Float, key: String) {
        defaults.set(value, forKey: key)
    }
    
    func removeAllKeysForUserDefaults() {
        defaults.removeObject(forKey: "EUR")
        defaults.removeObject(forKey: "GBP")
        defaults.removeObject(forKey: "INR")
    }
    
    func accessQuotesFromUserDefaults(_ key: String) -> Float {
        let quote = defaults.float(forKey: key)
        if quote != 0 {
            return quote
        }
        else {
            switch(key) {
                case "GBP": return 0.6427
                
                case "EUR": return 0.902
                
                case "INR": return 64.2234
                
                default: return 0
            }
        }
    }
    
    @IBAction func appendDigit(_ sender: UIButton) {
        if enableConversion {
            if usdInputLabel.text == "0" {
                usdInputLabel.text = sender.titleLabel!.text!
            }
            else {
                usdInputLabel.text = "\(usdInputLabel.text!)\(sender.titleLabel!.text!)"
            }
            convertToCurrencies()
        }
        else {
            displayAlert("Currently Downloading New Rates", message: "Please wait a moment before initating any conversion.")
            if sender.titleLabel?.text == "." {
                decimalDisabled = false
            }
        }
    }
    
    @IBAction func disableDecimalOnFirstUse(_ sender: UIButton) {
        if !decimalDisabled {
            decimalDisabled = true
            appendDigit(sender)
        }
        else {
            displayAlert("Invalid Decimal Point Insertion", message: "Adding another decimal would make the USD value invalid.")
        }
    }
    
    @IBAction func allClear(_ sender: UIButton) {
        if enableConversion {
            usdInputLabel.text = "0"
            decimalDisabled = false
            convertToCurrencies()
        }
    }
    
    @IBAction func deleteValue(_ sender: UIButton) {
        if enableConversion {
            if (usdInputLabel.text!).count == 1 {
                allClear(sender)
                decimalDisabled = false
                return
            }
            if usdInputLabel.text == "0" {
                displayAlert("Unable to Delete", message: "There is nothing to delete.")
            }
            else {
                let index = usdInputLabel.text?.index(before: (usdInputLabel.text?.endIndex)!)
                let lastChar = usdInputLabel.text!.remove(at: index!)
                if lastChar == "." {
                    decimalDisabled = false
                }
                convertToCurrencies()
            }
        }
        else {
            displayAlert("Currently Downloading New Rates", message: "Please wait a moment before initating any conversion.")
        }
    }
        
    
    
    @IBAction func saveConversion(_ sender: UIButton) {
        if usdInputLabel.text != "0" {
            let controller = storyboard?.instantiateViewController(withIdentifier: "AssociationView") as! AssociationViewController
            controller.baseVal = convertStringToFloat(usdInputLabel.text!)
            controller.eurVal = convertStringToFloat(eurOutputLabel.text!)
            controller.gbpVal = convertStringToFloat(gbpOutputLabel.text!)
            controller.inrVal = convertStringToFloat(inrOutputLabel.text!)
            self.present(controller, animated: true, completion: nil)
        }
        else {
            displayAlert("No Conversion Made", message: "You cannot save because you have not made a conversion.")
        }
    }
    
    @IBAction func refreshRates(_ sender: UIButton) {
        makeCurrencyQuoteRequest()
        activityindicator.isHidden = false
        activityindicator.startAnimating()
        refresh.isEnabled = false
    }
    
    func convertStringToFloat(_ string: String) -> Float {
        return (string as NSString).floatValue
    }
    
    func convertToCurrencies() {
        let usdVal = (usdInputLabel.text! as NSString).floatValue
        let euroVal = usdVal * (quotes["USDEUR"] as! Float)
        eurOutputLabel.text = String(format: "%.2f", euroVal)
        
        let gbpVal = usdVal * (quotes["USDGBP"] as! Float)
        gbpOutputLabel.text = String(format: "%.2f", gbpVal)
        
        let inrVal = usdVal * (quotes["USDINR"] as! Float)
        inrOutputLabel.text = String(format: "%.2f", inrVal)
    }
    
    
}




