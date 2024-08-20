//
//  MacroDayView.swift
//  MacroTracker
//
//  Created by Shivam Rishi on 20/8/2024.
//

import SwiftUI

struct MacroDayView: View {
    
    @State var macro: DailyMacro
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(macro.date.monthAndYear)
                    .font(.body)
                
                Text(macro.date.dayAndTime)
                    .font(.caption)
            }
            .frame(width:60)
            
            Spacer()
            
            HStack {
                MacroTitleView(titleName: "Carbs",
                               imageName: "carb",
                               value: macro.carbs)
                
                MacroTitleView(titleName: "Fats",
                               imageName: "fats",
                               value: macro.fats)
                
                MacroTitleView(titleName: "Protein",
                               imageName: "proteins",
                               value: macro.protein)
            }
            Spacer()
        }
        .padding(5)
    }
}

#Preview {
    MacroDayView(macro: DailyMacro(date: .now, carbs: 0, fats: 0, protein: 0))
}
