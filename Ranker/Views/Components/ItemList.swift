//
//  ItemList.swift
//  Ranker
//
//  Created by Will D on 11/11/24.
//

import SwiftUI

struct ItemList: View {
    var list: [ItemModel]
    var deletable: Bool = false
    var deleteAction: (ItemModel) -> Void = { _ in }
    
    var body: some View {
        ScrollView {
            VStack {
                LazyVStack {
                    ForEach(list) { element in
                        HStack {
                            element.image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                                .frame(width: 60, height: 60)
                                .foregroundColor(.black)
                                .padding(.horizontal, 6)
                            Text(element.title)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.black)
                            Spacer()
                            
                            if deletable {
                                Image(systemName: "trash")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.red)
                                    .frame(width: 30, height: 30)
                                    .padding(.horizontal)
                                    .onTapGesture {
                                        Task {
                                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                        }
                                        deleteAction(element)
                                    }
                            }
                        }
                        .padding(2)
                        .background(.white)
                        .cornerRadius(10)
                        .dropBorder(shapeType: .roundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
}
