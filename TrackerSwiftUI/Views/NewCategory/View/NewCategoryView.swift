//
//  NewCategoryView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 07.12.2025.
//

import SwiftUI

struct NewCategoryView: View {
    
    @StateObject var viewModel = NewCategoryViewModel()
    
    var body: some View {
        Text("New category")
            .font(Font.system(size: 32, weight: .bold))
            .padding(.top)
        TextField(text: $viewModel.categoryName, label: {
            Text("Enter category name")
                .padding(.vertical)
        })
        .onChange(of: viewModel.categoryName) { newValue, _ in
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
            
        } label: {
            Text("Add Category")
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
        
    }
}

#Preview {
    NewCategoryView()
}
