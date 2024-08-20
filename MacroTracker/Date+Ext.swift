//
//  Date+Ext.swift
//  MacroTracker
//
//  Created by Shivam Rishi on 20/8/2024.
//

import Foundation

extension Date {
    var monthAndYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM YYYY"
        return formatter.string(from: self)
    }
    
    var dayAndTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE d @ h:mm a"
        return formatter.string(from: self)
    }
}
