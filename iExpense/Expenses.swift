//
//  Expenses.swift
//  iExpense
//
//  Created by Rodrigo Tarouco on 03/05/22.
//

import Foundation

class Expenses: ObservableObject {
    @Published var personalItems = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(personalItems) {
                UserDefaults.standard.set(encoded, forKey: "personalItems")
            }
        }
    }
    
    @Published var businessItems = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(businessItems) {
                UserDefaults.standard.set(encoded, forKey: "businessItems")
            }
        }
    }
    
    init() {
        if let personalSavedItems = UserDefaults.standard.data(forKey: "personalItems") {
            if let decodedItens = try? JSONDecoder().decode([ExpenseItem].self, from: personalSavedItems) {
                personalItems = decodedItens
                return
            }
        }
        personalItems = []
        if let businessSavedItens = UserDefaults.standard.data(forKey: "businessItems") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: businessSavedItens) {
                businessItems = decodedItems
                return
            }
        }
        businessItems = []
    }    
}
