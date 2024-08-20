//
//  MacroItemView.swift
//  MacroTracker
//
//  Created by Shivam Rishi on 14/8/2024.
//

import SwiftUI

struct MacroHeaderView: View {
    
    var carbs: Int
    var fats: Int
    var proteins: Int
    
    var body: some View {
        HStack {
            Spacer()
            
            MacroTitleView(titleName: "Carbs",
                           imageName: "carb",
                           value: carbs)
            
            Spacer()
        
            MacroTitleView(titleName: "Fats",
                           imageName: "fats",
                           value: fats)
            
            Spacer()
            
            MacroTitleView(titleName: "Protein",
                           imageName: "proteins",
                           value: proteins)
            
            Spacer()
        }
    }
}

#Preview {
    MacroHeaderView(carbs: 0, fats: 0, proteins: 0)
}

struct MacroTitleView: View {
    
    let titleName: String
    let imageName: String
    let value: Int
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
    
            Text(titleName)
            
            Text("\(value) g")
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray.opacity(0.1))
        )
    }
}
