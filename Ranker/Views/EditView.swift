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
    @State private var rotation: Double = 0.0
    @State private var floatingButtonIsAnimating: Bool = false
    @State private var addOptionButtonIsAnimating: Bool = false
    
    var body: some View {
        Background {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    LazyVStack {
                        ForEach(listModel.elements) { element in
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
                                        listModel.elements.removeAll { $0.id == element.id }
                                    }
                            }
                            .padding(2)
                            .background(.white)
                            .cornerRadius(10)
                            .dropBorder(shapeType: .roundedRectangle(cornerRadius: 10))
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            }
            
            // MARK: Floating add button
            Image(systemName: "plus")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.black)
                .padding(12)
                .background(.white)
                .clipShape(Circle())
                .dropBorder(shapeType: .circle, isAnimating: $floatingButtonIsAnimating)
                .padding()
                .springButton(isAnimating: $floatingButtonIsAnimating) {
                    showAddOptionSheet.toggle()
                }
                .sheet(isPresented: $showAddOptionSheet) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Name")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                        
                        TextField("", text: $title, prompt: Text("Enter option name").foregroundStyle(.gray))
                            .padding()
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .bold))
                            .background(.white)
                            .cornerRadius(10)
                            .dropBorder(shapeType: .roundedRectangle(cornerRadius: 10))
                        HStack {
                            PhotosPicker(selection: $pictureItem, matching: .images) {
                                Text("Choose a picture")
                                    .font(.system(size: 20, weight: .semibold))
                                
                                    .padding(.vertical)
                            }
                            Spacer()
                            
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                                .frame(width: 60, height: 60)
                                .foregroundColor(.black)
                                .padding(.horizontal, 6)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 3)
                                )
                        }
                        .padding(.horizontal)
                        .onChange(of: pictureItem) {
                            Task {
                                if let loaded = try? await pictureItem?.loadTransferable(type: Image.self) {
                                    image = loaded
                                } else {
                                    image = Image(systemName: "photo")
                                }
                                
                            }
                        }
                        
                        Text("Add")
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .padding()
                            .background(.white)
                            .clipShape(Capsule())
                            .dropBorder(shapeType: .capsule, isAnimating: $addOptionButtonIsAnimating)
                            .springButton(isAnimating: $addOptionButtonIsAnimating) {
                                if title.isEmpty {
                                    title = "Option \(listModel.elements.count + 1)"
                                }
                                listModel.elements.append(ElementModel(title: title, image: image))
                                title = ""
                                image = Image(systemName: "photo")
                                showAddOptionSheet.toggle()
                            }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.backgroundColor)
                    .presentationDetents([.fraction(0.4)])
                    
                }
        }
    }
}

#Preview {
    EditView()
        .environmentObject(ListModel())
}
