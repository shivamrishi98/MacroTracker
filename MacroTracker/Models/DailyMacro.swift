//
//  DailyMacro.swift
//  MacroTracker
//
//  Created by Shivam Rishi on 20/8/2024.
//

import Foundation

struct DailyMacro: Identifiable {
    let id = UUID()
    let date: Date
    let carbs: Int
    let fats: Int
    let protein: Int
}
