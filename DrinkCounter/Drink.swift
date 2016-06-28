//
//  Drink.swift
//  DrinkCounter
//
//  Created by François Benaiteau on 29/05/16.
//  Copyright © 2016 François Benaiteau. All rights reserved.
//

import Foundation
import CoreData


class Drink: NSManagedObject {

    class func fetchAll(context: NSManagedObjectContext) -> [Drink]? {
        let fetchRequest = self.fetchAllRequest()
        guard let results = try? context.executeFetchRequest(fetchRequest) as? [Drink] else{
            return nil
        }
        return results
    }
    
    class func fetchAllRequest() -> NSFetchRequest {
        
        let request  = NSFetchRequest(entityName: self.entityName())
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return request
    }

    class func fetchAllTodayDrinksRequest() -> NSFetchRequest {
        
        let request  = NSFetchRequest(entityName: self.entityName())
        let today = NSDate().day()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        request.predicate = NSPredicate(format: "SUBQUERY(glasses, $glass, $glass.date > %@).@count > 0", today)
        return request
    }
    
    func todayGlassesCount() -> Int {
       let todayGlasses = glasses?.filteredSetUsingPredicate(NSPredicate(format:"SELF.date > %@", NSDate().day()))
        return todayGlasses != nil ? todayGlasses!.count : 0
    }

}
