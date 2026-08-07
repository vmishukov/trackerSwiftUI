//
//  ScheduleView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 03.01.2026.
//

import SwiftUI

struct ScheduleView: View {
    
    @StateObject var viewModel: ScheduleViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Text("Schedule")
            .font(Font.system(size: 32, weight: .bold))
            .padding(.top)
        ScrollView {
            LazyVGrid(columns: [.init(.flexible())], spacing: 0) {
                ForEach($viewModel.scheduleDayModels) { $model in
                    makeItemView(with: $model.title.wrappedValue, isOn: $model.isOn)
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.gray.opacity(0.2))
            }
            .padding(.horizontal)
        }
        
        Button {
            viewModel.doneButtonTapped()
        } label: {
            Text("Done")
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
        .onChange(of: viewModel.isClosing) {
            dismiss()
        }
        Spacer()
    }
}

// MARK: - PRIVATE
private extension ScheduleView {
    func makeItemView(with title: String, isOn: Binding<Bool>) -> some View {
        HStack {
            Text(title)
                .font(Font.system(size: 20, weight: .regular))
                .padding(.leading)
                .padding(.vertical, 26)
            Spacer()
            Toggle("", isOn: isOn)
                .padding(.trailing)
        }
    }
}

#Preview {
    ScheduleView(viewModel: ScheduleViewModel(selectedSchedule: .constant([.friday])))
}
