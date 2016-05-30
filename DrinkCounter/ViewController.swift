//
//  ViewController.swift
//  DrinkCounter
//
//  Created by François Benaiteau on 29/05/16.
//  Copyright © 2016 François Benaiteau. All rights reserved.
//

import UIKit

protocol Provided {
    var provider: Provider? { get }
    func receiveProvider(provider: Provider)
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, Provided {
    
    var dataSource:CoreDataCollectionDataSource?
    
    let provider: Provider? = Provider()
    func receiveProvider(provider: Provider) {
        // do nothing
    }
    
    let cellIdentifier = "com.fbenaiteau.drinkCell"
//    let data:Array<Drink> = [
//        Drink.init(title: "Caipirina", quantity: 2),
//        Drink.init(title: "Beer", quantity: 1),
//        Drink.init(title: "Red Wine", quantity: 1),
//        Drink.init(title: "Pina Colada", quantity: 2),
//        Drink.init(title: "Gordons", quantity: 2),
//        Drink.init(title: "Rum shot", quantity: 1)]
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Today's Drinks"
        // fetch data
        dataSource = CoreDataCollectionDataSource(fetchController: (provider?.fetchDrinksController())!, collectionView: collectionView)
        dataSource?.refresh()

    }

    @IBAction func addDrink(sender: AnyObject) {
        performSegueWithIdentifier("com.fbenaiteau.segue.addDrink", sender: self)
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource!.objectsCount()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! DrinkCell
        if let drink = dataSource?.fetchController.objectAtIndexPath(indexPath) as? Drink {
            cell.titleLabel.text = drink.name
            let quantity = (drink.glasses != nil) ? drink.glasses!.count : 0
            cell.quantityLabel.text = "\(quantity)"
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(CGRectGetWidth(collectionView.frame),
                          100)
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  segue.identifier == "com.fbenaiteau.segue.addDrink" {
            if let nav = segue.destinationViewController as? UINavigationController {
                
                guard let vc = nav.viewControllers.first as? Provided else {
                    return
                }
                vc.receiveProvider(provider!)
            }
            
        }
    }
    
    // MARK: - Private
    
    
    //    private func fetchTimeEntries() {
    //        fetchController = NSFetchedResultsController(fetchRequest: self.fetchRequest, managedObjectContext: coreDataStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
    //        fetchController?.delegate = self
    //        do {
    //            try fetchController?.performFetch()
    //        }catch let error {
    //            print(error)
    //        }
    //    }
    //
    //    private func objectAtIndexPath(indexPath:NSIndexPath) -> TimeEntry? {
    //        if let timeEntries = fetchController?.fetchedObjects,
    //            let timeEntry = timeEntries[indexPath.row] as? TimeEntry {
    //            return timeEntry
    //        }
    //        return nil
    //    }
    
}

