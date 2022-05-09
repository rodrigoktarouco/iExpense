//
//  AddView.swift
//  iExpense
//
//  Created by Rodrigo Tarouco on 03/05/22.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    let types = ["Business", "Personal"]
    @State private var currencies = ["USD", "EUR", "BR", "CAN", "AUS", "NZD"]
    @State private var chosenCurrency = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                Picker("Currency", selection: $chosenCurrency) {
                    ForEach(currencies, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: "\(currencies)")).keyboardType(.decimalPad)
            }
            .navigationTitle("Add a new expense")
            .toolbar {
                Button("Save") {
                    withAnimation {
                        let item = ExpenseItem(name: name, type: type, amount: amount, chosenCurrency: chosenCurrency)
                        if item.type == "Personal" {
                            expenses.personalItems.append(item)
                        } else {
                            expenses.businessItems.append(item)
                        }
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
