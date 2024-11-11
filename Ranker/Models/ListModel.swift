//
//  ListModel.swift
//  Ranker
//
//  Created by Will D on 11/9/24.
//

import Foundation

class ListModel: ObservableObject, Equatable {
    static func == (lhs: ListModel, rhs: ListModel) -> Bool {
        lhs.elements == rhs.elements
    }
    
    @Published var elements: [ElementModel] = []
}
