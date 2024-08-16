//
//  MacroView.swift
//  MacroTracker
//
//  Created by Shivam Rishi on 14/8/2024.
//

import SwiftUI

struct MacroView: View {
    
    @State var carbs = 10
    @State var fats = 40
    @State var proteins = 80
    
    @State var showTextfield = false
    @State var food = ""
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Text("Today's Macros")
                        .font(.title)
                        .padding()
                    
                    MacroItemView(carbs: $carbs, fats: $fats, proteins: $proteins)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Previous Meals")
                            .font(.title)
                        
                        ForEach(0..<10) { _ in
                            MacroItemView(carbs: .constant(Int.random(in: 10..<200)),
                                          fats: .constant(Int.random(in: 10..<200)),
                                          proteins: .constant(Int.random(in: 10..<200)))
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .scrollIndicators(.hidden)
            .alert("MacroTracker", isPresented: $showTextfield, actions: {
                TextField("Food", text: $food)
                
                Button("Cancel", role: .cancel, action:{})
                Button("Done") {
                    Task {
                        do {
                            print("food")
//                            try await OpenAIService.shared.sendPromptToChatGPT(message: food)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }, message: {
                Text("Please enter the meal you want to track")
            })
            .toolbar {
                ToolbarItem {
                    
                    Button {
                        showTextfield = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    MacroView()
}
