//
//  QuizView.swift
//  Ranker
//
//  Created by Will D on 11/9/24.
//

import SwiftUI

struct QuizView: View {
    
    @EnvironmentObject private var listModel: ListModel
    
    var body: some View {
        Text("\(listModel.elements.count)")
    }
}

#Preview {
    QuizView()
}
