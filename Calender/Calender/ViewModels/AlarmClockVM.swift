//
//  AlarmClockVM.swift
//  Calender
//
//  Created by Apple on 18/02/25.
//

import Foundation
import SwiftUI

class AlarmClockVM: ObservableObject {
    // Total minutes since 12:00 (in a 12-hour cycle).
    // For example, 90 represents 1:30.
    @Published var totalMinutes: Double = 0
    @Published var hourHandOffset: Double? = nil
    @Published var minuteHandOffset: Double? = nil
    
    @Published var label: String = "Label"
    @Published var amorpm: String = "AM"
    @Published var frequency: String = "Daily"
    @Published var type: String = "Normal"
    @Published var alarmSound: String = "default"
    @Published var snoozeAfter: String = "5min"
    @Published var vibrate: Bool = false
    
    var minuteArrowAngle: Angle {
        Angle.degrees((totalMinutes.truncatingRemainder(dividingBy: 60)) * 6)
    }
    
    var hourArrowAngle: Angle {
        Angle.degrees((totalMinutes / 60) * 30)
    }
    
    // Display the alarm time in HH:MM format.
    var hours: Int {
        Int(totalMinutes / 60) % 12
    }
    var minutes: Int {
        Int(totalMinutes.truncatingRemainder(dividingBy: 60))
    }
    
    func onMinutesDrag(value: DragGesture.Value, center: CGPoint) {
        let vector = CGVector(dx: value.location.x - center.x,
                                dy: value.location.y - center.y)
        var angleInDegrees = atan2(vector.dy, vector.dx) * 180 / .pi
        if angleInDegrees < 0 { angleInDegrees += 360 }
        
        // Capture initial offset for the minute hand.
        if minuteHandOffset == nil {
            let currentMinute = totalMinutes.truncatingRemainder(dividingBy: 60)
            let currentAngle = currentMinute * 6
            minuteHandOffset = angleInDegrees - currentAngle
        }
        
        let newAngle = angleInDegrees - (minuteHandOffset ?? 0)
        let newMinute = newAngle / 6
        
        let currentMinute = totalMinutes.truncatingRemainder(dividingBy: 60)
        var delta = newMinute - currentMinute
        // Handle wrap-around.
        if delta > 30 { delta -= 60 }
        else if delta < -30 { delta += 60 }
        
        totalMinutes += delta
    }
    
    func onHoursDrag(value: DragGesture.Value, center: CGPoint) {
        
        let vector = CGVector(dx: value.location.x - center.x,
                                dy: value.location.y - center.y)
        var angleInDegrees = atan2(vector.dy, vector.dx) * 180 / .pi
        if angleInDegrees < 0 { angleInDegrees += 360 }
        
        // On first update, capture the offset.
        if hourHandOffset == nil {
            let currentAngle = (totalMinutes / 60) * 30
            hourHandOffset = angleInDegrees - currentAngle
        }
        // Use the offset to update the hand angle smoothly.
        let newAngle = angleInDegrees - (hourHandOffset ?? 0)
        totalMinutes = (newAngle / 30) * 60
    }
    
    func onAppear() {
        // Initialize to the current system time (in a 12-hour cycle).
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now) % 12
        let minute = calendar.component(.minute, from: now)
        totalMinutes = Double(hour * 60 + minute)
    }
    
    func getCalenderModelData() -> AlarmModel {
        let calender = Calendar.current
        let adjustedHour = (amorpm == "AM") ? (hours == 12 ? 0 : hours) : (hours == 12 ? 12 : hours + 12)
        let components = DateComponents(hour: adjustedHour, minute: minutes)
        var time = ""
        if let date = calender.date(from: components){
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            time = formatter.string(from: date)
        }
        
        return AlarmModel(time: time, label: label, amorpm: amorpm, frequency: frequency, type: type, alarmSound: alarmSound, snoozeAfter: snoozeAfter, vibrate: vibrate)
    }
}


struct AlarmModel {
    var time: String
    var label: String
    var amorpm: String
    var frequency: String
    var type: String
    var alarmSound: String
    var snoozeAfter: String
    var vibrate: Bool
}
