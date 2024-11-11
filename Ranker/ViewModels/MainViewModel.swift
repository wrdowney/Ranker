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
    @Published var items: [ItemModel] = []
    private var pairings: [PairModel] = []
    private var currentIndex: Int = 0
    
    func addItem(_ item: ItemModel) {
        items.append(item)
    }
    
    func deleteItem(_ item: ItemModel) {
        items.removeAll { $0.id == item.id }
    }
    
    func chooseItem(_ item: ItemModel) {
        let pair = currentPair
        let loser = pair.first.id == item.id ? pair.second : pair.first
        let newScore = item.score + (1 + (loser.score / 2))
        items = items.map { $0.id == item.id ? item.updateScore(score: newScore) : $0 }
        nextPair()
    }
    
    func generatePairs() {
        for i in 0..<items.count {
            for j in i+1..<items.count {
                pairings.append(PairModel(first: items[i], second: items[j]))
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
    
    func rankItems() -> [ItemModel] {
        return items.sorted { $0.score > $1.score }
    }
}
