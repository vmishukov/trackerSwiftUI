//
//  ScheduleViewModel.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 03.01.2026.
//

import Combine
import SwiftUI

final class ScheduleViewModel: ObservableObject {
    
    @Binding var selectedSchedule: [ScheduleWeekDay]?
    @Published var scheduleDayModels: [ScheduleModel] = []
    @Published var isClosing: Bool = false
    
    init(selectedSchedule: Binding<[ScheduleWeekDay]?>) {
        _selectedSchedule = selectedSchedule
        setupScheduleDayModels()
    }
    
    func doneButtonTapped() {
        selectedSchedule = scheduleDayModels.filter { $0.isOn }.map { $0.weekDay }
        isClosing = true
    }
}

// MARK: - PRIVATE EXTENSION
private extension ScheduleViewModel {
    
    func setupScheduleDayModels() {
        let selectedSchedule = selectedSchedule ?? []
        
        scheduleDayModels = [
            ScheduleModel(title: "Monday", weekDay: .monday, isOn: selectedSchedule.contains { $0 == .monday}),
            ScheduleModel(title: "Tuesday", weekDay: .tuesday, isOn: selectedSchedule.contains { $0 == .tuesday}),
            ScheduleModel(title: "Wednesday", weekDay: .wednesday, isOn: selectedSchedule.contains { $0 == .wednesday}),
            ScheduleModel(title: "Thursday", weekDay: .thursday, isOn: selectedSchedule.contains { $0 == .thursday}),
            ScheduleModel(title: "Friday", weekDay: .friday, isOn: selectedSchedule.contains { $0 == .friday}),
            ScheduleModel(title: "Saturday", weekDay: .saturday, isOn: selectedSchedule.contains { $0 == .saturday}),
            ScheduleModel(title: "Sunday", weekDay: .sunday, isOn: selectedSchedule.contains { $0 == .sunday}),
        ]
    }
}
