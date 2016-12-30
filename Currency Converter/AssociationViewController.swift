//
//  AssociationViewController.swift
//  Currency Converter
//
//  Created by Mayank Kumar on 7/29/15.
//  Copyright (c) 2015 Mayank Kumar. All rights reserved.
//

import UIKit
import CoreData

class AssociationViewController: UIViewController, UITextFieldDelegate {
    
    var baseVal: Float!
    var eurVal: Float!
    var gbpVal: Float!
    var inrVal: Float!
    var association: String!
    var appDel: AppDelegate  {
       return UIApplication.shared.delegate as! AppDelegate
    }
    
    var sharedContext: NSManagedObjectContext {
        return appDel.managedObjectContext!
    }
    
    @IBOutlet var associationField: UITextField!
    
    override func viewDidLoad() {
        associationField.delegate = self
    }
    
    @IBAction func saveConversion(_ sender: UIButton) {
        association = associationField.text
        if association == "" {
            association = "0"
        }
        let dictionary = [
            "baseVal": baseVal,
            "eurVal": eurVal,
            "gbpVal": gbpVal,
            "inrVal": inrVal,
            "association": association
        ] as [String : Any]
        _ = Conversion(dictionary: dictionary as [String : AnyObject], context: sharedContext)
        appDel.saveContext()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelSave(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
}
