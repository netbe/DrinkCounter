//
//  NSDate+Additions.swift
//  DrinkCounter
//
//  Created by François Benaiteau on 01/06/16.
//  Copyright © 2016 François Benaiteau. All rights reserved.
//

import Foundation



extension NSDate {
    func day() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let units: NSCalendarUnit = [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day]
        let components = calendar.components(units, fromDate: self)
        return calendar.dateFromComponents(components)!
    }
}