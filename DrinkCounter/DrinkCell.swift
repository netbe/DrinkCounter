//
//  DrinkCell.swift
//  DrinkCounter
//
//  Created by François Benaiteau on 29/05/16.
//  Copyright © 2016 François Benaiteau. All rights reserved.
//

import UIKit

class DrinkCell : UICollectionViewCell {
    var quantityIncrease : ((newValue: Int) -> ())?
    var quantity: Int = 0 {
        didSet {
            quantityLabel.text = "\(quantity)"
        }
    }
    

    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        quantity += 1
        if let block = quantityIncrease {
            block(newValue: quantity)
        }
    }
}