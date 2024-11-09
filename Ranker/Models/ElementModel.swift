//
//  ElementModel.swift
//  Ranker
//
//  Created by Will D on 11/9/24.
//

import Foundation

struct ElementModel: Identifiable, Codable {
    var id: UUID = UUID()
    let title: String
    let image: String
}
