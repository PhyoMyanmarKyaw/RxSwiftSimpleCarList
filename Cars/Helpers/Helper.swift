//
//  Helper.swift
//  Cars
//
//  Created by PhyoMyanmarKyaw on 26/03/2022.
//

import Foundation

struct Helper {
    
    static func isSameYear (date1: Date, date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.year],
                                  from: date1, to: date2)
        return diff.year == 0 ? true : false
    }
    
    static func getCustomDateFormatString(_ date: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm" //25.05.2022 14:13
        formatter.locale = Locale(identifier: "en_US_POSIX")
        let newDate = formatter.date(from: date)
        
        guard let newDate = newDate else { return "" }
        formatter.dateFormat = "\(isSameYear(date1: Date(), date2: newDate) ? "dd MMM" : "dd MMM yyyy"), \(Locale.is12HoursFormat() ? "hh:mm a" : "HH:mm")"
        return formatter.string(from: newDate)
    }
}





