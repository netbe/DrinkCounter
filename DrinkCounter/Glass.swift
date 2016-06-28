//
//  Glass.swift
//  DrinkCounter
//
//  Created by François Benaiteau on 29/05/16.
//  Copyright © 2016 François Benaiteau. All rights reserved.
//

import Foundation
import CoreData


class Glass: NSManagedObject {

    class func fetchAllRequest() -> NSFetchRequest {
        let request  = NSFetchRequest(entityName: self.entityName())
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        request.predicate = NSPredicate(format: "date > %@", NSDate().day())
        return request
    }
    
    var day:NSDate {
        return (date?.day())!
    }

    
}
