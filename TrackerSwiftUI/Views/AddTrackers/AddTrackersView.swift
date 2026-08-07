//
//  AddTrackersView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 27.11.2025.
//

import SwiftUI

struct AddTrackersView: View {
    
    @State private var newTrackerViewIsPresented: Bool = false
    @State private var oneTimeActionIsPresented: Bool = false
    @State private var shouldClose: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Add new tracker")
                .font(Font.system(size: 32, weight: .bold))
                .padding(.top)
            Spacer()
            makeAddButton(title: "Add tracker") {
                newTrackerViewIsPresented.toggle()
            }
            .padding(.bottom, 8)
            makeAddButton(title: "One time action") {
                oneTimeActionIsPresented.toggle()
            }
            Spacer()
        }
        .sheet(isPresented: $newTrackerViewIsPresented) {
            Builder.makeNewTrackerView(addTrackerClose: $shouldClose)
        }
        .sheet(isPresented: $oneTimeActionIsPresented) {
            Builder.makeNewTrackerView(isOneTimeAction: true, addTrackerClose: $shouldClose)
        }
        .onChange(of: shouldClose) { oldValue , newValue in
            if newValue{
                dismiss()
            }
        }
    }
}

private extension AddTrackersView {
    
    func makeAddButton(title: String, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text(title)
                .padding(.vertical)
                .frame(maxWidth: .greatestFiniteMagnitude)
                .foregroundStyle(.white)
                .background(.addButton)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .circular))
                .padding(.horizontal)
            
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AddTrackersView()
}
