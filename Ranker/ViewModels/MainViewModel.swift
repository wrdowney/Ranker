//
//  QuizView+ViewModel.swift
//  Ranker
//
//  Created by Will D on 11/11/24.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var currentPair: PairModel = PairModel()
    @Published var isQuizComplete: Bool = false
    private var listModel: ListModel
    private var pairings: [PairModel] = []
    private var currentIndex: Int = 0
    
    init() {
        listModel = ListModel()
    }
    
    func addItem(_ item: ItemModel) {
        listModel.items.append(item)
    }
    
    func deleteItem(_ item: ItemModel) {
        listModel.items.removeAll { $0.id == item.id }
    }
    
    func getItems() -> [ItemModel] {
        return listModel.items
    }
    
    func chooseItem(_ item: ItemModel) {
        let pair = currentPair
        let loser = pair.first.id == item.id ? pair.second : pair.first
        let newScore = item.score + (1 + (loser.score / 2))
        listModel.updateItemScore(item: item, score: newScore)
        nextPair()
    }
    
    func generatePairs() {
        for i in 0..<listModel.items.count {
            for j in i+1..<listModel.items.count {
                pairings.append(PairModel(first: listModel.items[i], second: listModel.items[j]))
            }
        }
        pairings.shuffle()
        currentPair = pairings[currentIndex]
    }
   
    func nextPair() {
        currentIndex += 1
        if currentIndex < pairings.count {
            currentPair = pairings[currentIndex]
        } else {
            isQuizComplete = true
        }
    }
}
