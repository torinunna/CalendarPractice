//
//  CalendarDay.swift
//  CalendarPractice
//
//  Created by YUJIN KWON on 2022/12/24.
//

import Foundation

class CalendarDay {
    var day: String!
    var month: Month!
    
    enum Month {
        case previous
        case current
        case next
    }
}
