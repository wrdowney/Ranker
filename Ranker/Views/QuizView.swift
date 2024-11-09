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
        VStack {
            if listModel.elements.count < 2 {
                Text("Add at least two elements in the edit tab to start the quiz.")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.red)
                    .padding()
            } else {
                Text("Quiz")
                    .font(.title)
                    
            }
        }
    }
}

#Preview {
    QuizView()
        .environmentObject(ListModel())
}
