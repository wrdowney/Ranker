//
//  ElementModel.swift
//  Ranker
//
//  Created by Will D on 11/9/24.
//

import Foundation
import SwiftUI

struct ElementModel: Identifiable {
    var id: UUID = UUID()
    let title: String
    let image: Image
    private(set) var score: Int = 0
}
