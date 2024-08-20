//
//  AddMacroView.swift
//  MacroTracker
//
//  Created by Shivam Rishi on 20/8/2024.
//

import SwiftUI

struct AddMacroView: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var food:String = ""
    @State private var date = Date()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Add Macro")
                .font(.largeTitle)
            
            TextField("What did you eat?", text: $food)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15)
                    .stroke())
            
            DatePicker("Date", selection: $date)
            
            Button {
                Task {
                    do {
                        print("food")
                        let macroResult = try await OpenAIService.shared.sendPromptToChatGPT(message: food)
                        saveMacro(macroResult)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Done")
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color(.systemBackground))
                    .background(RoundedRectangle(cornerRadius: 15)
                        .fill(Color(.label)))
            }
        }
        .padding(.horizontal)
    }
    
    private func saveMacro(_ result: MacroResult) {
        let macro = Macro(food: result.food,
                          createdAt: .now,
                          date: .now,
                          carbs: result.carbs,
                          fats: result.fats,
                          protein: result.protein)
        modelContext.insert(macro)
    }  
}

#Preview {
    AddMacroView()
}
