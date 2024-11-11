//
//  ElementModel.swift
//  Ranker
//
//  Created by Will D on 11/9/24.
//

import Foundation
import SwiftUI

struct ItemModel: Identifiable, Equatable {
    var id: UUID = UUID()
    let title: String
    let image: Image
    var score: Double = 0.0
    
    func updateScore(score: Double) -> Self {
        var copy = self
        copy.score = score
        return copy
    }
    
    init (title: String = "", image: Image = Image("")) {
        self.title = title
        self.image = image
    }
}
