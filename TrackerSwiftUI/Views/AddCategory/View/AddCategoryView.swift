//
//  AddCategoryView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 07.12.2025.
//

import SwiftUI

struct AddCategoryView: View {
    @StateObject var viewModel = AddCategoryViewModel()
    
    var body: some View {
        Text("Category")
            .font(Font.system(size: 32, weight: .bold))
            .padding(.top)
        Spacer()
        
        ScrollView {
            VStack {
                LazyVGrid(columns: [.init(.flexible())],
                          spacing: 0) {
                    makeCategoryView(with: "Plant trees")
                    Divider()
                        .padding(.horizontal)
                        .background(.gray.opacity(0.2))
                    makeCategoryView(with: "Shower")
                    Divider()
                        .padding(.horizontal)
                        .background(.gray.opacity(0.2))
                    makeCategoryView(with: "Groceries")
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .circular))
            .padding()
        }
        
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
            NewCategoryView()
        }
    }
}

// MARK: - PRIVATE
private extension View {
    
    func makeCategoryView(with title: String) -> some View {
        Button {
            
        } label: {
            Text(title)
                .font(Font.system(size: 20, weight: .regular))
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.2))
                .foregroundStyle(Color.primary)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AddCategoryView()
}
