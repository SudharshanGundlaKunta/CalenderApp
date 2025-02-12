//
//  SecondApproch.swift
//  Calender
//
//  Created by Apple on 11/02/25.
//

import SwiftUI

struct MonthDetails: Codable {
    var year: Int
    var month, englishMonth: String
    var days: [DayDetails]
}

struct DayDetails: Codable {
    var date, teluguDate, day, festival: String
    var details: MoreDetails
}

struct MoreDetails: Codable {
    var tithi, nakshatra, yoga, karana, sunrise, sunset, moonrise, moonset, rahuKalam: String
}
