//
//  Weekday.swift
//  test2
//
//  Created by Marina Lunts on 11.06.2018.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import Foundation

extension Date {
    func dayNumberOfWeek() -> Int? {
        return (Calendar.current.dateComponents([.weekday], from: self).weekday! - 1)
    }
}
