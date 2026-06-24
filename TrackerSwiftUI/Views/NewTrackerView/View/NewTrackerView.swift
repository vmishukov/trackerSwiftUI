//
//  NewTrackerView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 29.11.2025.
//

import SwiftUI

struct NewTrackerView: View {
    
    @ObservedObject var viewModel: NewTrackerViewModel
    @Environment(\.dismiss) private var dismiss
    
    public init(viewModel: NewTrackerViewModel) {
        self.viewModel = viewModel
    }
    
    private var collectionColumns = Array(repeating: GridItem(.flexible()), count: 6)
    
    var body: some View {
        ScrollView {
            Text(viewModel.titleString)
                .font(Font.system(size: 32, weight: .bold))
                .padding(.top)
            TextField("Enter tracker name",
                      text: $viewModel.trackerName)
            .font(Font.system(size: 20))
            .padding(.vertical, 20)
            .padding(.horizontal, 10)
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.gray.opacity(0.2))
            }
            .padding(.horizontal, 20)
            trackersConfigView
            visualConfigGridView
        }
        bottomView
        .onReceive(viewModel.$isClosing) { isClosing in
            guard isClosing else { return }
            dismiss()
        }
        .sheet(isPresented: $viewModel.addCategoryIsPresented) {
            AddCategoryView()
        }
        .sheet(isPresented: $viewModel.scheduleIsPresented) {
            ScheduleView()
        }
    }
}

// MARK: - PRIVATE METHODS
private extension NewTrackerView {
    
    var bottomView: some View {
        HStack(spacing: 16) {
            Button {
                viewModel.isClosing = true
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
            .disabled(!viewModel.canCreateTracker)
        }.padding(.horizontal, 20)
    }
    
    var trackersConfigView: some View {
        ZStack {
            VStack(spacing: 0) {
                Button {
                    viewModel.addCategoryIsPresented.toggle()
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
                if !viewModel.isOneTimeAction {
                    Button {
                        viewModel.scheduleIsPresented.toggle()
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
            }
            
            RoundedRectangle(cornerRadius: 8, style: .circular)
                .fill(.gray)
                .frame(height: 1)
                .padding(.horizontal)
                .opacity(viewModel.isOneTimeAction ? 0 : 1)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding(.horizontal, 20)
    }
    
    var visualConfigGridView: some View {
        VStack(spacing: 24) {
            LazyVGrid(columns: collectionColumns, spacing: 8) {
                ForEach(viewModel.emojis, id: \.id) { emoji in
                    Text(emoji.emoji)
                        .font(Font.system(size: 40))
                        .background {
                            RoundedRectangle(cornerRadius: 8, style: .circular)
                                .fill(.gray.opacity(viewModel.selectedEmojiId == emoji.id ? 0.2 : 0))
                        }
                        .onTapGesture {
                            viewModel.selectedEmojiId = emoji.id
                        }
                }
            }
            LazyVGrid(columns: collectionColumns, spacing: 8) {
                ForEach(viewModel.colors, id: \.id) { colorModel in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(colorModel.color)
                        .aspectRatio(1, contentMode: .fit)
                        .padding(3)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.clear)
                                .stroke(colorModel.color.opacity(viewModel.selectedColorId == colorModel.id ? 1 : 0),
                                        lineWidth: 2)
                        }
                        .onTapGesture {
                            viewModel.selectedColorId = colorModel.id
                        }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

#Preview {
    NewTrackerView(viewModel: NewTrackerViewModel(isOneTimeAction: false))
}
