//
//  FiltersView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 25.06.2026.
//

import SwiftUI

struct FiltersView: View {
    
    @ObservedObject private var viewModel: FiltersViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: FiltersViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("Filters")
            .font(Font.system(size: 32, weight: .bold))
            .padding(.top)
        ScrollView {
            VStack(spacing: 0) {
                makeFilterButton(type: .allTrackers)
                Divider()
                makeFilterButton(type: .completedTrackers)
                Divider()
                makeFilterButton(type: .uncopletedTrackers)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .padding(.horizontal)
    }
    
    func makeFilterButton(title: String,
                          action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background {
                    Color.filterButton
                        .opacity(0.7)
                }
                .foregroundStyle(.white)
            
        }
        .buttonStyle(.plain)
    }
    
    func makeFilterButton(type: TrackerFilterType) -> some View {
        Button {
            viewModel.selectFilter(type)
            dismiss()
        } label: {
            ZStack {
                Text(type.title)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background {
                        Color.filterButton
                            .opacity(0.7)
                    }
                    .foregroundStyle(.white)
                if viewModel.selectedFilter == type {
                    HStack {
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)
                }
            }
            
        }
        .buttonStyle(.plain)
    }
    
}

#Preview {
    FiltersView(viewModel: FiltersViewModel(selectedFilter: .constant(.allTrackers)))
}
