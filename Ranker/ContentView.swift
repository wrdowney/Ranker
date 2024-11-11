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
    
    @State var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Header()
                TabView(selection: $selectedTab) {
                    EditView()
                        .tag(0)
                    QuizView()
                        .tag(1)
                }
                .toolbarBackground(Color.backgroundColor, for: .tabBar)
            }
            ZStack {
                HStack {
                    ForEach(TabItems.allCases, id: \.self) { tab in
                        Button {
                            selectedTab = tab.rawValue
                        } label: {
                            CustomTabItem(imageName: tab.systemImage, text: tab.title, isActive: selectedTab == tab.rawValue)
                        }
                    }
                }
                .padding(6)
            }
            .frame(width: 190, height: 50)
            .background(.white)
            .cornerRadius(10)
            .dropBorder(shapeType: .roundedRectangle(cornerRadius: 10))
            .padding(4)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor)
    }
}

extension ContentView {
    func CustomTabItem(imageName: String, text: String, isActive: Bool) -> some View {
        HStack(spacing: 10) {
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 25, height: 25)
            if isActive {
                Text(text)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(isActive ? .black : .gray)
            }
            Spacer()
        }
        .frame(width: isActive ? 110 : 60, height: 40)
        .background(isActive ? .blue.opacity(0.15) : .clear)
        .cornerRadius(20)

    }
}

enum TabItems: Int, CaseIterable {
    case edit = 0
    case quiz
    
    var title: String {
        switch self {
        case .edit:
            return "Edit"
        case .quiz:
            return "Quiz"
        }
    }
    
    var systemImage: String {
        switch self {
        case .edit:
            return "pencil"
        case .quiz:
            return "questionmark"
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(MainViewModel())
}
