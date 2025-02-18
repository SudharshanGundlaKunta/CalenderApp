//
//  AlarmDashboardVM.swift
//  Calender
//
//  Created by Apple on 17/02/25.
//

import Foundation

class AlarmDashboardVM: ObservableObject {
    @Published var count: Int = 1
    @Published var isOn: Bool = false
}
