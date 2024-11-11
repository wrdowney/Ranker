//
//  PairModel.swift
//  Ranker
//
//  Created by Will D on 11/11/24.
//

struct PairModel {
    var first: ItemModel
    var second: ItemModel
    
    init(first: ItemModel = ItemModel(), second: ItemModel = ItemModel()) {
        self.first = first
        self.second = second
    }
}
