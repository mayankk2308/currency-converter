//
//  Conversion.swift
//  
//
//  Created by Mayank Kumar on 7/28/15.
//
//

import Foundation
import CoreData

@objc(Conversion)

class Conversion: NSManagedObject {

    @NSManaged var association: String
    @NSManaged var baseValue: NSNumber
    @NSManaged var eurValue: NSNumber
    @NSManaged var gbpValue: NSNumber
    @NSManaged var inrValue: NSNumber
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(dictionary: [String:AnyObject], context: NSManagedObjectContext) {
        
        let entity = NSEntityDescription.entity(forEntityName: "Conversion", in: context)!
        super.init(entity: entity, insertInto: context)
        
        association = dictionary["association"] as! String
        baseValue = dictionary["baseVal"] as! NSNumber
        eurValue = dictionary["eurVal"] as! NSNumber
        gbpValue = dictionary["gbpVal"] as! NSNumber
        inrValue = dictionary["inrVal"] as! NSNumber
    }

}
