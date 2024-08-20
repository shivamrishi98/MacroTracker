//
//  MacroView.swift
//  MacroTracker
//
//  Created by Shivam Rishi on 14/8/2024.
//

import SwiftUI
import SwiftData

struct MacroView: View {

    @State var carbs = 0
    @State var fats = 0
    @State var proteins = 0
    
    @Query() var macros: [Macro] = []
    @State var dailyMacros = [DailyMacro]()
    
    @State var showTextfield = false
    @State var food = ""
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Text("Today's Macros")
                        .font(.largeTitle)
                        .padding()
                    
                    MacroHeaderView(carbs: carbs, fats: fats, proteins: proteins)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Previous Meals")
                            .font(.title)
                        
                        ForEach(dailyMacros) { macro in
                            HStack {
                                MacroDayView(macro: macro)
                            }
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .scrollIndicators(.hidden)
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
            .sheet(isPresented: $showTextfield) {
                AddMacroView()
                    .presentationDetents([.fraction(0.4)])
            }
            .onAppear {
                fetchDailyMacros()
                fetchTodaysMacros()
            }
            .onChange(of: macros) { _, _ in
                fetchDailyMacros()
                fetchTodaysMacros()
            }
        }
    }
    
    private func fetchDailyMacros() {
        let dates: Set<Date> = Set(macros.map({ Calendar.current.startOfDay(for: $0.date) }))
        
        var dailyMacros = [DailyMacro]()
        for date in dates {
            let filteredMacros = macros.filter({ Calendar.current.startOfDay(for:  $0.date ) == date })
            let carbs: Int = filteredMacros.reduce(0, { $0 + $1.carbs })
            let fats: Int = filteredMacros.reduce(0, { $0 + $1.fats })
            let protein: Int = filteredMacros.reduce(0, { $0 + $1.protein })
            
            let macro = DailyMacro(date: date, carbs: carbs, fats: fats, protein: protein)
            dailyMacros.append(macro)
        }
        self.dailyMacros = dailyMacros.sorted(by: { $0.date > $1.date })
    }
    
    private func fetchTodaysMacros() {
        if let firstDateMacro = dailyMacros.first,
           Calendar.current.startOfDay(for: firstDateMacro.date) == Calendar.current.startOfDay(for: .now) {
            carbs = firstDateMacro.carbs
            fats = firstDateMacro.fats
            proteins = firstDateMacro.protein
        }
    }
}

#Preview {
    MacroView()
}
