//
//  NewTrackerView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 29.11.2025.
//

import SwiftUI

struct NewTrackerView: View {
    
    @State private var trackerName: String = ""
    @State private var canCreateTracker: Bool = true
    
    @State private var selectedEmojiId: UUID?
    @State private var selectedColorId: UUID?
    
    private let emojis = NewTrackerEmojiModel.makeEmojisModel()
    private let colors = NewTrackerColorModel.makeColorModels()
    private var collectionColumns = Array(repeating: GridItem(.flexible()), count: 6)
    
    var body: some View {
        ScrollView {
            Text("New Habbit")
                .font(Font.system(size: 32, weight: .bold))
                .padding(.top)
            TextField("Enter tracker name",text: $trackerName)
                .font(Font.system(size: 20))
                .padding(.vertical, 20)
                .padding(.horizontal, 10)
                .background {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.gray.opacity(0.2))
                }
                .padding(.horizontal, 20)
            
            ZStack {
                VStack(spacing: 0) {
                    Button {
                        
                    } label: {
                        HStack {
                            Text("Category")
                            Spacer()
                            Image(systemName: "chevron.forward")
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 25)
                        .background {
                            Rectangle()
                                .fill(.gray.opacity(0.3))
                        }
                    }
                    .buttonStyle(.plain)
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Text("Schedule")
                            Spacer()
                            Image(systemName: "chevron.forward")
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 25)
                        .background {
                            Rectangle()
                                .fill(.gray.opacity(0.3))
                        }
                    }
                    .buttonStyle(.plain)
                }
                
                RoundedRectangle(cornerRadius: 8, style: .circular)
                    .fill(.gray)
                    .frame(height: 1)
                    .padding(.horizontal)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding(.horizontal, 20)
            
            VStack(spacing: 24) {
                LazyVGrid(columns: collectionColumns, spacing: 8) {
                    ForEach(emojis, id: \.id) { emoji in
                        Text(emoji.emoji)
                            .font(Font.system(size: 40))
                            .background {
                                RoundedRectangle(cornerRadius: 8, style: .circular)
                                    .fill(.gray.opacity(selectedEmojiId == emoji.id ? 0.2 : 0))
                            }
                            .onTapGesture {
                                selectedEmojiId = emoji.id
                            }
                    }
                }
                LazyVGrid(columns: collectionColumns, spacing: 8) {
                    ForEach(colors, id: \.id) { colorModel in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(colorModel.color)
                            .aspectRatio(1, contentMode: .fit)
                            .padding(3)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.clear)
                                    .stroke(colorModel.color.opacity(selectedColorId == colorModel.id ? 1 : 0),
                                            lineWidth: 2)
                            }
                            .onTapGesture {
                                selectedColorId = colorModel.id
                            }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            
            HStack(spacing: 16) {
                Button {
                } label: {
                    Text("Cancel")
                        .foregroundStyle(.red.opacity(0.8))
                        .frame(maxWidth: .greatestFiniteMagnitude)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 16, style: .circular)
                                .fill(Color.white.opacity(0.1))
                                .stroke(.red.opacity(0.5), lineWidth: 2)
                        }
                }
                .buttonStyle(.plain)
                Button {
                    
                } label: {
                    Text("Create")
                        .foregroundStyle(.white)
                        .frame(maxWidth: .greatestFiniteMagnitude)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 16, style: .circular)
                                .fill(Color.black.opacity(0.8))
                        }
                }
                .buttonStyle(.plain)
                .disabled(!canCreateTracker)
            }.padding(.horizontal, 20)
        }
    }
}

#Preview {
    NewTrackerView()
}
