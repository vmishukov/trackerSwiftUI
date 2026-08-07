//
//  NewCategoryView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 07.12.2025.
//

import SwiftUI
import SwiftData

struct NewCategoryView: View {
    
    var modelToEdit: TrackerCategory?
    
    @StateObject var viewModel = NewCategoryViewModel()
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        Text(modelToEdit == nil ? "New category" : "Edit category")
            .font(Font.system(size: 32, weight: .bold))
            .padding(.top)
        TextField(text: $viewModel.categoryName, label: {
            Text("Enter category name")
                .padding(.vertical)
        })
        .onChange(of: viewModel.categoryName) { _ , newValue in
            viewModel.checkCategoryNameLenght()
        }
        .padding(.horizontal)
        .padding(.vertical, 25)
        .background(.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .circular))
        .padding(.horizontal)
        .padding(.top, 10)
        
        Spacer()
        Button {
            if let modelToEdit {
                viewModel.editCategory(modelContext: modelContext,
                                       category: modelToEdit)
            } else {
                viewModel.insertCategory(modelContext: modelContext)
            }
        } label: {
            Text(modelToEdit == nil ? "Add Category" : "Save changes")
                .font(Font.system(size: 20, weight: .medium))
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(.black)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .padding(.horizontal)
            
        }
        .buttonStyle(.plain)
        .padding(.bottom)
        .disabled(viewModel.categoryName.isEmpty)
        .onAppear {
            viewModel.onDismiss = {
                dismiss()
            }
        }
        .alert("This category already exists, please pick another name",
               isPresented: $viewModel.showErrorAlert) {
            Button { } label: {
                Text("Ok")
            }
        }
    }
}

#Preview {
    NewCategoryView()
}
