//
//  QuizView.swift
//  Ranker
//
//  Created by Will D on 11/9/24.
//

import SwiftUI

struct QuizView: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    @State private var isFirstOptionAnimating = false
    @State private var isSecondOptionAnimating = false
    
    var body: some View {
        Background {
            VStack(alignment: .center) {
                Spacer()
                if mainViewModel.getItems().count < 2 {
                    Text("Add at least two elements in the edit tab to start the quiz.")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    if !mainViewModel.isQuizComplete {
                        VStack {
                            Text("Pick one option?")
                                .font(.title)
                            HStack {
                                VStack {
                                    mainViewModel.currentPair.first.image
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(10)
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 6)
                                    Text(mainViewModel.currentPair.first.title)
                                        .font(.title)
                                }
                                    .padding()
                                    .background(.white)
                                    .cornerRadius(10)
                                    .dropBorder(shapeType: .roundedRectangle(cornerRadius: 10))
                                    .springButton(isAnimating: $isFirstOptionAnimating){
                                        mainViewModel.chooseItem(mainViewModel.currentPair.first)
                                    }
                                
                                
                                Text("or")
                                    .font(.title)
                                VStack {
                                    mainViewModel.currentPair.second.image
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(10)
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 6)
                                    
                                    Text(mainViewModel.currentPair.second.title)
                                        .font(.title)
                                }
                                    .padding()
                                    .background(.white)
                                    .cornerRadius(10)
                                    .dropBorder(shapeType: .roundedRectangle(cornerRadius: 10))
                                    .springButton(isAnimating: $isSecondOptionAnimating){
                                        mainViewModel.chooseItem(mainViewModel.currentPair.second)
                                    }
                            }
                        }
                    } else {
                        Text("Quiz complete!")
                            .font(.title)
                    }
                    
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            mainViewModel.generatePairs()
        }
    }
}

#Preview {
    QuizView()
        .environmentObject(MainViewModel())
}
