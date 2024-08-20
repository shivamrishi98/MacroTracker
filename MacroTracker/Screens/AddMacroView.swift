//
//  AddMacroView.swift
//  MacroTracker
//
//  Created by Shivam Rishi on 20/8/2024.
//

import SwiftUI

struct AddMacroView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var food:String = ""
    @State private var date = Date()
    @State private var showAlert = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 20) {
                Text("Add Macro")
                    .font(.largeTitle)
                
                TextField("What did you eat?", text: $food)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15)
                        .stroke())
                
                DatePicker("Date", selection: $date)
                
                Button {
                    if food.count > 2 {
                        sendItemToChatGPT()
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
            .padding(.top, 24)
            .padding(.horizontal)
            .alert("Ooops",
                   isPresented: $showAlert) {
                Text("Ok")
            } message: {
                Text("We were unable to verify the food item.  Please make sure you enter a valid food item and try again.")
            }
            
            Button("", systemImage: "x.circle.fill") {
                dismiss()
            }
            .font(.title)
            .foregroundStyle(.primary)
        }

    }
    
    private func sendItemToChatGPT() {
        Task {
            do {
                let macroResult = try await OpenAIService.shared.sendPromptToChatGPT(message: food)
                saveMacro(macroResult)
            } catch {
                if let openAIError = error as? OpenAIError {
                    switch openAIError {
                    case .noFunctionCall:
                        showAlert = true
                        print(error.localizedDescription)
                    case .unableToConvertStringIntoData:
                        print(error.localizedDescription)
                    }
                } else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func saveMacro(_ result: MacroResult) {
        dismiss()
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
