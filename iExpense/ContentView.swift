//
//  ContentView.swift
//  iExpense
//
//  Created by Rodrigo Tarouco on 02/05/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Text("Personal")
                        .foregroundColor(.black)
                        .font(.title)
                    ForEach(expenses.personalItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            switch item.amount {
                            case 0...10.0:
                                Text(item.amount, format: .currency(code: "\(item.chosenCurrency)")).foregroundColor(.blue)
                            case 10.0...100.0:
                                Text(item.amount, format: .currency(code: "\(item.chosenCurrency)")).foregroundColor(.yellow)
                            default:
                                Text(item.amount, format: .currency(code: "\(item.chosenCurrency)")).foregroundColor(.red)
                            }
                            
                        }
                    }
                    .onDelete(perform: removePersonalItems)
                    Text("Business")
                        .foregroundColor(.black)
                        .font(.title)
                    ForEach(expenses.businessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            switch item.amount {
                            case 0...10.0:
                                Text(item.amount, format: .currency(code: "\(item.chosenCurrency)")).foregroundColor(.blue)
                            case 10.0...100.0:
                                Text(item.amount, format: .currency(code: "\(item.chosenCurrency)")).foregroundColor(.yellow)
                            default:
                                Text(item.amount, format: .currency(code: "\(item.chosenCurrency)")).foregroundColor(.red)
                            }
                        }
                    }
                    .onDelete(perform: removeBusinessItems)
                    
                }
                .navigationTitle("iExpense")
            }.toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        expenses.personalItems.remove(atOffsets: offsets)
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        expenses.businessItems.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
