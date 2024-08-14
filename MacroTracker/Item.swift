//
//  Item.swift
//  MacroTracker
//
//  Created by Shivam Rishi on 14/8/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
