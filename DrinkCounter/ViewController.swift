//
//  ViewController.swift
//  DrinkCounter
//
//  Created by François Benaiteau on 29/05/16.
//  Copyright © 2016 François Benaiteau. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    struct Drink {
        let title: String
        let quantity: Int
    }
    
    
    let cellIdentifier = "com.fbenaiteau.drinkCell"
    let data:Array<Drink> = [
        Drink.init(title: "Caipirina", quantity: 2),
        Drink.init(title: "Beer", quantity: 1),
        Drink.init(title: "Red Wine", quantity: 1),
        Drink.init(title: "Pina Colada", quantity: 2),
        Drink.init(title: "Gordons", quantity: 2),
        Drink.init(title: "Rum shot", quantity: 1)]
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let stack : CoreDataStack = CoreDataStack()
    //    let fetchResultsDelegate: CoreDataCollectionDataSource
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Today's Drinks"
        // fetch data
        
    }

    @IBAction func addDrink(sender: AnyObject) {
        performSegueWithIdentifier("com.fbenaiteau.segue.addDrink", sender: self)
    }
    
    func objectsCount() -> Int {
        //        guard let count = fetchController?.fetchedObjects?.count else { return 0 }
        //        return count
        return data.count
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectsCount()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! DrinkCell
        let drink = data[indexPath.row]
        cell.titleLabel.text = drink.title
        cell.quantityLabel.text = "\(drink.quantity)"
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(CGRectGetWidth(collectionView.frame),
                          100)
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

