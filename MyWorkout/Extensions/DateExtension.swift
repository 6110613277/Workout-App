//
//  DateExtension.swift
//  MyWorkout
//
//  Created by Siriluk Rachaniyom on 11/9/2564 BE.
//

import Foundation

extension Date {
    func formatted(as format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self) //มันจะเปลี่ยนค่าที่ได้รับมาเป็น string
    }
    
    func isSameDay(as day: Date) -> Bool {
        self.yearMonthDay == day.yearMonthDay
    }
    
    var yearMonthDay : String {
        formatted(as: "yyyy MM dd")
    }
}
