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
        GeometryReader { proxy in
            let height: CGFloat = proxy.size.height
            let width: CGFloat = proxy.size.width
            
            ZStack(alignment: .bottomTrailing) {
                Color.backgroundColor
                    .ignoresSafeArea(.all)
                
                Image(systemName: "triangle")
                    .font(.system(size: 120, weight: .semibold))
                    .foregroundColor(.label)
                    .rotationEffect(Angle(degrees: 165))
                    .padding(24)
                    .opacity(0.4)
                    .offset(x: 0, y: -height * 0.65)
                
                Image(systemName: "triangle")
                    .font(.system(size: 120, weight: .semibold))
                    .foregroundColor(.label)
                    .rotationEffect(Angle(degrees: 65))
                    .padding(24)
                    .opacity(0.4)
                    .offset(x: -width * 0.4, y: -height * 0.45)
                
                Image(systemName: "triangle")
                    .font(.system(size: 120, weight: .semibold))
                    .foregroundColor(.label)
                    .rotationEffect(Angle(degrees: 135))
                    .padding(24)
                    .opacity(0.4)
                    .offset(x: 0, y: -height * 0.25)
                
                Image(systemName: "triangle")
                    .font(.system(size: 120, weight: .semibold))
                    .foregroundColor(.label)
                    .rotationEffect(Angle(degrees: 45))
                    .padding(24)
                    .opacity(0.4)
                    .offset(x: -width * 0.4, y: -height * 0.05)
                
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
                                .shadow(color: Color(.black), radius: 0, x: 3, y: 3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 3)
                                    )
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
                    .shadow(color: Color(.black), radius: 0, x: floatingButtonIsAnimating ? 0 : 3, y: floatingButtonIsAnimating ? 0 : 3)
                    .overlay(
                        Circle()
                            .stroke(Color.black, lineWidth: 3)
                        )
                    .padding()
                    .onTapGesture {
                        Task {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        }
                        withAnimation(.spring(response: 0.15, dampingFraction: 0.3, blendDuration: 0.1)) {
                            floatingButtonIsAnimating.toggle()
                        } completion: {
                            withAnimation(.spring(response: 0.15, dampingFraction: 0.3, blendDuration: 0.1)) {
                                floatingButtonIsAnimating.toggle()
                                showAddOptionSheet.toggle()
                            }
                        }
                    }
                    .offset(x: floatingButtonIsAnimating ? 3 : 0, y: floatingButtonIsAnimating ? 3 : 0)
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
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 3)
                                )
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
                                .shadow(
                                    color: Color(.black),
                                    radius: 0,
                                    x: addOptionButtonIsAnimating ? 0 : 3,
                                    y: addOptionButtonIsAnimating ? 0 : 3
                                )
                                .overlay(
                                    Capsule()
                                        .stroke(Color.black, lineWidth: 3)
                                    )
                                .springButton(isAnimating: $addOptionButtonIsAnimating, offset: 3) {
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
}

#Preview {
    EditView()
        .environmentObject(ListModel())
}
