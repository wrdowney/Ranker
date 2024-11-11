//
//  QuizView.swift
//  Ranker
//
//  Created by Will D on 11/9/24.
//

import SwiftUI

struct QuizView: View {
    @EnvironmentObject private var listModel: ListModel
    @State private var pairings: [(ElementModel, ElementModel, Int)] = []
    @State private var currentComparison: Int = 0
    
    var body: some View {
        ZStack {
            VStack {
                if listModel.elements.count < 2 {
                    Text("Add at least two elements in the edit tab to start the quiz.")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    Text("Which is better?")
                        .font(.title)
                    
                    if !pairings.isEmpty || currentComparison < pairings.count - 1 {
                        HStack {
                            Text(pairings[currentComparison].0.title)
                                .font(.title)
                                .padding()
                                .onTapGesture {
                                    pairings[currentComparison].2 = 0
                                    currentComparison += 1
                                }
                            Text("vs")
                                .font(.title)
                                .padding()
                            Text(pairings[currentComparison].1.title)
                                .font(.title)
                                .padding()
                                .onTapGesture {
                                    pairings[currentComparison].2 = 1
                                    currentComparison += 1
                                }
                        }
                    }
                }
            }
        }
        .ignoresSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor)
        .onAppear {
            generatePairings()
        }
    }
    
    /// Generates the pairings for the quiz.
    ///
    /// Each element in the list will be compared against each other element only once.
    func generatePairings() {
        for i in 0..<listModel.elements.count {
            for j in (i + 1)..<listModel.elements.count {
                let element1 = listModel.elements[i]
                let element2 = listModel.elements[j]
                pairings.append((element1, element2, -1))
            }
        }
    }
}

#Preview {
    QuizView()
        .environmentObject(ListModel())
}
