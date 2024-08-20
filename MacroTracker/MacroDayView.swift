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
            VStack(alignment: .center) {
                Text(macro.date.monthAndYear)
                    .font(.title3)
                
                Text(macro.date.dayAndTime)
            }
            .frame(width: 80, alignment: .center)
            Spacer()
            
            HStack {
                VStack {
                    Image("carb")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                    
                    Text("Carbs")
                    
                    Text("\(macro.carbs) g")
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray.opacity(0.1))
                )
                VStack {
                    Image("fats")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                    
                    Text("Fats")
                    
                    Text("\(macro.fats) g")
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray.opacity(0.1))
                )
                VStack {
                    Image("proteins")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                    
                    Text("Protein")
                    
                    Text("\(macro.protein) g")
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray.opacity(0.1))
                )
            }
            Spacer()
        }
    }
}

#Preview {
    MacroDayView(macro: DailyMacro(date: .now, carbs: 0, fats: 0, protein: 0))
}
