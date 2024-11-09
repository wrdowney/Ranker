//
//  EditView.swift
//  Ranker
//
//  Created by Will D on 11/9/24.
//

import SwiftUI

struct EditView: View {
    @EnvironmentObject private var listModel: ListModel
    
    var body: some View {
        List {
            ForEach(listModel.elements) { element in
                HStack {
                    Text(element.title)
                        .font(.headline)
                    Spacer()
                    Image(element.image)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                    Button {
                        listModel.elements.removeAll { $0.id == element.id }
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
            
            Button {
                listModel.elements.append(ElementModel(title: "", image: ""))
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}

#Preview {
    EditView()
}
