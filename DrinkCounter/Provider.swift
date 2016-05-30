//
//  Provider.swift
//  DrinkCounter
//
//  Created by François Benaiteau on 29/05/16.
//  Copyright © 2016 François Benaiteau. All rights reserved.
//

import Foundation
import CoreData

class Provider: NSObject {
    let stack : CoreDataStack = CoreDataStack()
    
    func saveDrink(name: String, completion: ((success: Bool) -> ())?) {
        guard let completionBlock = completion else {
            return
        }
        let context = stack.backgroundContext
        context.performBlock {
            var success: Bool
            defer {
                dispatch_async(dispatch_get_main_queue(), {
                    if success {
                        self.stack.saveContext()
                    }
                    completionBlock(success:success)
                })
            }
            let drink = Drink(context: context)
            drink.name = name
            
            do {
                try context.save()
            }catch(let error) {
                print(error)
                success = false
                return
            }
            success = true
        }
    }
    
    func fetchDrinksController() -> NSFetchedResultsController {
        let fetchController = NSFetchedResultsController(fetchRequest: Drink.fetchAllRequest(), managedObjectContext: stack.mainContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchController
    }
   
    
}