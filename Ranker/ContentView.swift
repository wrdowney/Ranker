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
    
    @AppStorage("items") private var savedItems: Data = Data()
    
    @State private var items: [Item] = [
        Item(title: "Item 1", image: "image1", description: "Description 1"),
        Item(title: "Item 2", image: "image2", description: "Description 2"),
        Item(title: "Item 3", image: "image3", description: "Description 3")
    ] {
        didSet {
            
        }
    }
    
    @State private var selectedItems: [Item] = []
    @State private var isEditModeActive: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(items) { item in
                        HStack {
                            Image(item.image)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.headline)
                                Text(item.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            
                        }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
