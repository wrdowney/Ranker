//
//  ListModel.swift
//  Ranker
//
//  Created by Will D on 11/9/24.
//

import Foundation

class ListModel: ObservableObject {
    @Published var elements: [ElementModel] = []
}
