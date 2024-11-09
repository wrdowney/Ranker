//
//  EditView.swift
//  Ranker
//
//  Created by Will D on 11/9/24.
//
import PhotosUI
import SwiftUI

struct EditView: View {
    @EnvironmentObject private var listModel: ListModel
    @State private var title = ""
    @State private var pictureItem: PhotosPickerItem?
    @State private var image: Image = Image(systemName: "photo")
    @State private var showAddOptionSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(listModel.elements) { element in
                    HStack {
                        Text(element.title)
                            .font(.headline)
                        Spacer()
                        element.image
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                    }
                }
                .onDelete {
                    listModel.elements.remove(atOffsets: $0)
                }
            }
            .listStyle(.plain)
            .padding()
            .toolbar {
                EditButton()
            }
            
            Button {
                showAddOptionSheet.toggle()
                Task {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                }
            } label: {
                Text("Add option")
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
            }
            .sheet(isPresented: $showAddOptionSheet) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Option name:")
                    TextField("Title", text: $title)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)

                    VStack(alignment: .center) {
                        PhotosPicker(selection: $pictureItem, matching: .images) {
                            VStack {
                                image
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                Text("Add an image!")
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    Button {
                        listModel.elements.append(ElementModel(title: title, image: image))
                        title = ""
                        image = Image(systemName: "photo")
                        showAddOptionSheet.toggle()
                        Task {
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                    } label: {
                        Text("Add")
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .presentationDetents([.fraction(0.50)])
                .onChange(of: pictureItem) {
                    Task {
                        if let loaded = try? await pictureItem?.loadTransferable(type: Image.self) {
                            image = loaded
                        } else {
                            image = Image(systemName: "photo")
                        }
                    }
                }
                .padding()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.gray))
    }
}

#Preview {
    EditView()
        .environmentObject(ListModel())
}
