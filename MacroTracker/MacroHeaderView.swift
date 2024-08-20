//
//  MacroItemView.swift
//  MacroTracker
//
//  Created by Shivam Rishi on 14/8/2024.
//

import SwiftUI

struct MacroHeaderView: View {
    
    @Binding var carbs: Int
    @Binding var fats: Int
    @Binding var proteins: Int
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Image("carb")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                
                Text("Carbs")
                
                Text("\(carbs) g")
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray.opacity(0.1))
            )
            
            Spacer()
            VStack {
                Image("fats")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                
                Text("Fats")
                
                Text("\(fats) g")
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray.opacity(0.1))
            )
            
            Spacer()
            VStack {
                Image("proteins")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                
                Text("Protein")
                
                Text("\(proteins) g")
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray.opacity(0.1))
            )
            
            Spacer()
        }
    }
}

#Preview {
    MacroHeaderView(carbs: .constant(10), fats: .constant(82), proteins: .constant(120))
}
