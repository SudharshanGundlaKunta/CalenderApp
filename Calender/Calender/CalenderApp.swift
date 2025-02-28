//
//  CalenderApp.swift
//  Calender
//
//  Created by Apple on 10/02/25.
//

import SwiftUI

@main
struct CalenderApp: App {
    
    init() {
        LocalNotificationManager.shared.requestForAuthorisation()
    }
    
    var body: some Scene {
        WindowGroup {
            AlarmDashboardView()
        }
    }
}
