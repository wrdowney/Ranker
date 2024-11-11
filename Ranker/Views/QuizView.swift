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
                if mainViewModel.items.count < 2 {
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
                                .foregroundStyle(.black)
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
                                        .foregroundStyle(.black)
                                }
                                    .padding()
                                    .background(.white)
                                    .cornerRadius(10)
                                    .dropBorder(shapeType: .roundedRectangle(cornerRadius: 10), isAnimating: $isFirstOptionAnimating)
                                    .springButton(isAnimating: $isFirstOptionAnimating){
                                        mainViewModel.chooseItem(mainViewModel.currentPair.first)
                                    }
                                
                                
                                Text("or")
                                    .font(.title)
                                    .foregroundStyle(.black)
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
                                        .foregroundStyle(.black)
                                }
                                    .padding()
                                    .background(.white)
                                    .cornerRadius(10)
                                    .dropBorder(shapeType: .roundedRectangle(cornerRadius: 10), isAnimating: $isSecondOptionAnimating)
                                    .springButton(isAnimating: $isSecondOptionAnimating){
                                        mainViewModel.chooseItem(mainViewModel.currentPair.second)
                                    }
                            }
                        }
                    } else {
                        VStack(alignment: .leading) {
                            Text("Quiz complete!")
                                .font(.title)
                                .foregroundStyle(.black)
                            Text("Here's your ranking:")
                                .font(.title)
                                .foregroundStyle(.black)
                            ItemList(list: mainViewModel.rankItems())
                            Spacer()
                        }
                        .padding()
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
