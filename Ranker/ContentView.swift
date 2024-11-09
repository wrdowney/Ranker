//
//  ContentView.swift
//  Ranker
//
//  Created by Will D on 11/9/24.
//

import SwiftUI

struct Item: Identifiable, Codable {
    var id: UUID = UUID()
    let title: String
    let image: String
    let description: String
}

struct ContentView: View {
    
    var body: some View {
        TabView {
            EditView()
                .tabItem {
                    Label("Edit", systemImage: "pencil")
                }
            QuizView()
                .tabItem {
                    Label("Quiz", systemImage: "questionmark")
                }
        }
    }
}

#Preview {
    ContentView()
}
