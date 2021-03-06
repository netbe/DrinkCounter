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
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        guard let sectionCount = dataSource!.fetchController.sections?.count else { return 0 }
        return sectionCount
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let itemCount = dataSource!.fetchController.sections?[section].numberOfObjects else { return 0 }
        return itemCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! DrinkCell
        if let drink = dataSource?.fetchController.objectAtIndexPath(indexPath) as? Drink {
            cell.titleLabel.text = drink.name
            cell.quantity = drink.todayGlassesCount() //(drink.glasses != nil) ? drink.glasses!.count : 0
            cell.quantityIncrease = { newValue in
                
                self.provider?.addGlass(drink, completion: { (success) in
                    // do nothing
                })
            }
            
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
    
}
