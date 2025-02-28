//
//  PractiveAlarmView.swift
//  Calender
//
//  Created by Apple on 19/02/25.
//

import Foundation
import SwiftUI
import UserNotifications

class LocalNotificationManager {
    static let shared = LocalNotificationManager()
    var isAuthAvailable = false
    
    private init() {}
    
    func requestForAuthorisation() {
        let options: UNAuthorizationOptions = [.alert, .badge, .criticalAlert, .sound, .providesAppNotificationSettings]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { resultBool, error in
            if let error = error {
                print("ERROR Authorizing: \(error.localizedDescription)")
                return
            }
            if resultBool == true {
               print("Authrization Successful")
                self.isAuthAvailable = true
            }else {
                self.isAuthAvailable = false
                print("Authrization Failed")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.body = "This is body"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            
        }
    }
}

