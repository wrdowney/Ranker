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
                    .offset(x: 0, y: -height * 0.7)
                
                Image(systemName: "triangle")
                    .font(.system(size: 120, weight: .semibold))
                    .foregroundColor(.label)
                    .rotationEffect(Angle(degrees: 65))
                    .padding(24)
                    .opacity(0.4)
                    .offset(x: -width * 0.4, y: -height * 0.5)
                
                Image(systemName: "triangle")
                    .font(.system(size: 120, weight: .semibold))
                    .foregroundColor(.label)
                    .rotationEffect(Angle(degrees: 135))
                    .padding(24)
                    .opacity(0.4)
                    .offset(x: 0, y: -height * 0.3)
                
                Image(systemName: "triangle")
                    .font(.system(size: 120, weight: .semibold))
                    .foregroundColor(.label)
                    .rotationEffect(Angle(degrees: 45))
                    .padding(24)
                    .opacity(0.4)
                    .offset(x: -width * 0.4, y: -height * 0.1)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "person")
                                .resizable()
                                .foregroundColor(.black)
                                .padding(2)
                                .scaledToFit()
                                .background(.white)
                                .clipShape(Circle())
                                .shadow(color: Color(.black), radius: 0, x: 5, y: 5)
                                .overlay(
                                    Circle()
                                        .stroke(Color.black, lineWidth: 3)
                                )
                                .frame(width: 52, height: 52)
                            Spacer()
                            Button {
                                Task {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                }
                                withAnimation(.linear(duration: 0.5)) {
                                    rotation += 360
                                }
                            } label: {
                                Image(systemName: "gearshape")
                                    .font(.system(size: 28, weight: .bold))
                                    .rotationEffect(Angle(degrees: rotation))
                                    .foregroundStyle(.black)
                            }
                            .frame(width: 44, height: 44)
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal)
                        
                        Spacer()
                        List {
                            ForEach(listModel.elements) { element in
                                HStack {
                                    element.image
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    Text(element.title)
                                        .fontWeight(.bold)
                                    Spacer()
                                    Button {
                                        listModel.elements.removeAll { $0.id == element.id }
                                        
                                    } label: {
                                        Image(systemName: "trash")
                                            .fontWeight(.bold)
                                            .foregroundColor(.red)
                                    }
                                }
                                .listRowSeparator(.hidden)
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .border(Color(.black), width: 3)
                                .shadow(color: Color(.black), radius: 3, x: -5, y: 5)
                        
                            }
                            .listRowInsets(.init(top: 4, leading: 8, bottom: 4, trailing: 8))
                        }
                        .listStyle(.plain)
                    }
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
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        }
                        withAnimation(.spring(response: 0.15, dampingFraction: 0.3, blendDuration: 0.1)) {
                            floatingButtonIsAnimating.toggle()
                        } completion: {
                            withAnimation(.spring(response: 0.15, dampingFraction: 0.3, blendDuration: 0.1)) {
                                floatingButtonIsAnimating.toggle()
                            }
                        }
                        showAddOptionSheet.toggle()
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
//                                .shadow(color: Color(.black), radius: 0, x: 5, y: 5)
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
                            
                            Text("Add")
                                .frame(maxWidth: .infinity)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                                .padding()
                                .background(.white)
                                .clipShape(Capsule())
                                .shadow(color: Color(.black), radius: 0, x: 4, y: 4)
                                .overlay(
                                    Capsule()
                                        .stroke(Color.black, lineWidth: 3)
                                    )
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
