//
//  NSManagedObject+Additions.swift
//  TimeFlies
//
//  Created by François Benaiteau on 21/04/16.
//  Copyright © 2016 François Benaiteau. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    convenience init(context: NSManagedObjectContext) {
        let name = self.dynamicType.entityName()
        let entity = NSEntityDescription.entityForName(name, inManagedObjectContext: context)!
        self.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    class func entityName() -> String {
        return String(self.self)
    }
}