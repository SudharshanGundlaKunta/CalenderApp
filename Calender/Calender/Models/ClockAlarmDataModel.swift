//
//  ClockAlarmDataModel.swift
//  Calender
//
//  Created by Apple on 19/02/25.
//

import Foundation

struct ClockAlarmDataModel: Codable {
    var time: String
    var anORpm: String
    var label: String
    var frequecy: String
    var alarmStopingType: String
    var alarmSound: String
    var alarmSnooz: String
    var alarmVibrate: Bool
}
