//
//  Date+GetPreviousDaysFromToday.swift
//  APOD
//
//  Created by Vinoth Vino on 08/04/18.
//  Copyright © 2018 Coder Earth. All rights reserved.
//

import Foundation

extension Date {
    static func getPreviousTenDays(_ previousDaysCount: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: previousDaysCount, to: Date())!
    }
}
