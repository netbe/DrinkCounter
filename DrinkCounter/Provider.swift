//
//  Provider.swift
//  DrinkCounter
//
//  Created by François Benaiteau on 29/05/16.
//  Copyright © 2016 François Benaiteau. All rights reserved.
//

import Foundation
import CoreData

typealias CompletionBlock = ((success: Bool) -> ())?

class Provider: NSObject {
    let stack : CoreDataStack = CoreDataStack()
    
    func saveDrink(name: String, completion: CompletionBlock) {
        let context = stack.backgroundContext
        context.performBlock {
            var success: Bool
            defer {
                dispatch_async(dispatch_get_main_queue(), {
                    if success {
                        self.stack.saveContext()
                    }
                    if let completionBlock = completion {
                        completionBlock(success:success)
                    }
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
    
    func addGlass(drink:Drink, completion: CompletionBlock) {
        let now = NSDate()
        let context = stack.backgroundContext
        context.performBlock {
            var success: Bool
            defer {
                dispatch_async(dispatch_get_main_queue(), {
                    if success {
                        self.stack.saveContext()
                    }
                    if let completionBlock = completion {
                        completionBlock(success:success)
                    }
                })
            }
            let glass = Glass(context: context)
            let drinkInContext = context.objectWithID(drink.objectID) as? Drink
            glass.drink = drinkInContext
            glass.date = now
            
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