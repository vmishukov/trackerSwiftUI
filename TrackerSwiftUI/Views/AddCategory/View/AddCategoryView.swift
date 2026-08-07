//
//  AddCategoryView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 07.12.2025.
//

import SwiftUI
import SwiftData

struct AddCategoryView: View {
    
    @StateObject var viewModel: AddCategoryViewModel
    @Query var categories: [TrackerCategory]
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Category")
                .font(Font.system(size: 32, weight: .bold))
                .padding(.top)
            Spacer()
            List {
                ForEach(categories) { category in
                    VStack(spacing: 0) {
                        makeCategoryView(with: category)
                        if category.id != categories.last?.id {
                            Divider()
                                .background(Color.gray.opacity(0.3))
                                .padding(.horizontal, 16)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color(.gray).opacity(0.2))
                    .listRowSeparator(.hidden)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .contentMargins([.all], 16, for: .scrollContent)
            .listStyle(.insetGrouped)
            
            Button {
                viewModel.newCategoryIsPresented.toggle()
            } label: {
                Text("Add Category")
                    .font(Font.system(size: 20, weight: .medium))
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background(.addButton)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .padding(.horizontal)
                
            }
            .buttonStyle(.plain)
            .padding(.bottom)
            .sheet(isPresented: $viewModel.newCategoryIsPresented) {
                Builder.makeNewCategoryView()
                    .presentationDetents([.medium])
            }
            .sheet(isPresented: $viewModel.editCategoryIsPresented) {
                Builder.makeNewCategoryView(modelToEdit: viewModel.trackerCategoryToEdit)
                    .presentationDetents([.medium])
            }
        }
        
    }
}

// MARK: - PRIVATE
private extension AddCategoryView {
    
    func makeCategoryView(with category: TrackerCategory) -> some View {
        Text(category.title)
            .font(Font.system(size: 20, weight: .regular))
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .foregroundStyle(Color.primary)
            .swipeActions(allowsFullSwipe: false) {
                Button {
                    viewModel.removeTrackerCategory(modelContext: modelContext,
                                                    model: category)
                } label: {
                    Label("Delete", systemImage: "trash.fill")
                }
                .tint(.red)
                
                Button {
                    viewModel.trackerCategoryToEdit = category
                    viewModel.editCategoryIsPresented.toggle()
                } label: {
                    Label("Edit", systemImage: "square.and.pencil")
                }
                .tint(.indigo)
            }
            .onTapGesture {
                viewModel.selectedCategory = category
                dismiss()
            }
    }
}

#Preview {
    AddCategoryView(viewModel: AddCategoryViewModel(selectedCategory: .constant(TrackerCategory( title: "Test"))))
}
