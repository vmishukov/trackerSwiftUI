//
//  NewTrackerView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 29.11.2025.
//

import SwiftUI
import SwiftData

struct NewTrackerView: View {
    
    @ObservedObject var viewModel: NewTrackerViewModel
    var addTrackerClose: Binding<Bool>?
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    public init(viewModel: NewTrackerViewModel,
                addTrackerClose: Binding<Bool>?) {
        self.viewModel = viewModel
        self.addTrackerClose = addTrackerClose
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
                addTrackerClose?.wrappedValue = true
            }
            .sheet(isPresented: $viewModel.addCategoryIsPresented) {
                AddCategoryView(viewModel: AddCategoryViewModel(selectedCategory: $viewModel.selectedTrackerCategory))
            }
            .sheet(isPresented: $viewModel.scheduleIsPresented) {
                ScheduleView(viewModel: ScheduleViewModel(selectedSchedule: $viewModel.selectedSchedule))
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
                viewModel.createTracker(with: modelContext)
            } label: {
                Text(viewModel.enterButtonTitle)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .greatestFiniteMagnitude)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16, style: .circular)
                            .fill(Color.addButton.opacity(0.8))
                    }
            }
            .buttonStyle(.plain)
            .disabled(!viewModel.canCreateTracker)
        }.padding(.horizontal, 20)
    }
    
    var trackersConfigView: some View {
        VStack(spacing: 0) {
            Button {
                viewModel.addCategoryIsPresented.toggle()
            } label: {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Category")
                        if let categoryName = viewModel.selectedTrackerCategory?.title {
                            Text(categoryName)
                                .font(Font.system(size: 16, weight: .regular))
                                .opacity(0.8)
                        }
                    }
                    Spacer()
                    Image(systemName: "chevron.forward")
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 25)
            }
            .tint(.text)
            
            if !viewModel.isOneTimeAction {
                RoundedRectangle(cornerRadius: 8, style: .circular)
                    .fill(.gray)
                    .frame(height: 1)
                    .padding(.horizontal)
                    .opacity(viewModel.isOneTimeAction ? 0 : 1)
                Button {
                    viewModel.scheduleIsPresented.toggle()
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Schedule")
                            if let selectedSchedule = viewModel.selectedSchedule {
                                Text(
                                    selectedSchedule
                                        .map { $0.title }
                                        .joined(separator: ", ")
                                )
                                .font(.system(size: 16, weight: .regular))
                                .opacity(0.8)
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                            }
                        }
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 25)
                }
                .tint(.text)
            }
        }
        .background(Color.gray.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding(.horizontal, 20)
        
    }
    
    var visualConfigGridView: some View {
        VStack(spacing: 24) {
            LazyVGrid(columns: collectionColumns, spacing: 8) {
                ForEach(viewModel.emojis) { emoji in
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
                ForEach(viewModel.colors) { colorModel in
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
    NewTrackerView(viewModel: NewTrackerViewModel(isOneTimeAction: false), addTrackerClose: .constant(false))
}
