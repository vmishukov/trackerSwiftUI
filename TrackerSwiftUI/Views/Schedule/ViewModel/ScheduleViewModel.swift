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
        scheduleDayModels = [
            ScheduleModel(title: "Monday", weekDay: .monday, isOn: false),
            ScheduleModel(title: "Tuesday", weekDay: .tuesday, isOn: false),
            ScheduleModel(title: "Wednesday", weekDay: .wednesday, isOn: false),
            ScheduleModel(title: "Thursday", weekDay: .thursday, isOn: false),
            ScheduleModel(title: "Friday", weekDay: .friday, isOn: false),
            ScheduleModel(title: "Saturday", weekDay: .friday, isOn: false),
            ScheduleModel(title: "Sunday", weekDay: .friday, isOn: false),
        ]
    }
}
