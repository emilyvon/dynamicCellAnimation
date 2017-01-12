//
//  Helper.swift
//  testing-hero
//
//  Created by Mengying Feng on 12/1/17.
//  Copyright © 2017 iEmRollin. All rights reserved.
//

import Foundation

class Helper {
    
    static let shared = Helper()
    
    var weekdaysArr: [Int]?
 
    
    // MARK: convert weekday number to string
    func weekdayConverter(weekday: Int) -> String {
        switch weekday {
        case 1: return "Sunday"
        case 2: return "Monday"
        case 3: return "Tuesday"
        case 4: return "Wednesday"
        case 5: return "Thursday"
        case 6: return "Friday"
        case 7: return "Saturday"
        default: return ""
        }
    }

    
}
