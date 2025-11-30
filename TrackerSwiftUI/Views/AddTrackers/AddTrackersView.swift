//
//  AddTrackersView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 27.11.2025.
//

import SwiftUI

struct AddTrackersView: View {
    
    @State private var newTrackerViewIsPresented: Bool = false
    
    var body: some View {
        VStack {
            Text("Add new tracker")
                .font(Font.system(size: 32, weight: .bold))
                .padding(.top)
            Spacer()
            makeAddButton(title: "Add tracker", action: {
                newTrackerViewIsPresented.toggle()
            })
            .padding(.bottom, 8)
            makeAddButton(title: "One time action", action: {})
            Spacer()
        }
        .sheet(isPresented: $newTrackerViewIsPresented) {
            NewTrackerView()
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
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .circular))
                .padding(.horizontal)
            
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AddTrackersView()
}
