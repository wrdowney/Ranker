//
//  ListModel.swift
//  Ranker
//
//  Created by Will D on 11/9/24.
//

import Foundation

class ListModel: ObservableObject, Equatable {
    static func == (lhs: ListModel, rhs: ListModel) -> Bool {
        lhs.items == rhs.items
    }
    
    @Published var items: [ItemModel] = []
    
    func updateItemScore(item: ItemModel, score: Double) {
        items = items.map { $0.id == item.id ? item.updateScore(score: score) : $0 }
    }
}
