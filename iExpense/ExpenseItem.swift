//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Rodrigo Tarouco on 03/05/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}


