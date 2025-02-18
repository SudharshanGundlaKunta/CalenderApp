//
//  CalenderDashboardVM.swift
//  Calender
//
//  Created by Apple on 13/02/25.
//

import Foundation

class CalenderDashboardViewModel: ObservableObject {
    let calendar: Calendar = {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone.current
        cal.firstWeekday = 1 // Sunday
        return cal
    }()
    
    @Published var month: Int = 1
    @Published var year: Int = 2025
    let weekdays = ["ఆది", "సోమ", "మంగళ", "బుధ", "గురు", "శుక్ర", "శని"]
    let teluguMonths = ["జనవరి", "ఫిబ్రవరి", "మార్చి", "ఏప్రిల్", "మే", "జూన్", "జూలై", "ఆగస్టు", "సెప్టెంబర్", "అక్టోబర్", "నవంబర్", "డిసెంబర్"]
    @Published var days: [[String]] = []
    
    init() {
        month = calendar.component(.month, from: Date())
        year = calendar.component(.year, from: Date())
        self.loadData()
    }
    
    func loadData() {

        let dateComponents = DateComponents(year: self.year, month: self.month)
        guard let startDate = calendar.date(from: dateComponents),
              let range = calendar.range(of: .day, in: .month, for: startDate) else {
            fatalError("Invalid date components")
        }
        
        let firstDayWeekday = calendar.component(.weekday, from: startDate)
        let emptyCells = (firstDayWeekday - 1) % 7
        let totalDays = range.count
        
        var daysArray = [String](repeating: "", count: emptyCells)
        daysArray += (1...totalDays).map { String($0) }
        
        if daysArray.count > 35 {
            let extraCount = daysArray.count - 35
            let extraDays = daysArray.suffix(extraCount)
            daysArray.removeLast(extraCount)
            
            //MARK: Converting Array Slicing to array
            //let arrayOfExtraDays = Array(extraDays)
            //for i in 0..<arrayOfExtraDays.count {
             //   daysArray[i] = arrayOfExtraDays[i]
            //}
            //MARK: Actual ChatGPT code
             //Replace empty cells in the first week with these extra days.
            var extraIterator = extraDays.makeIterator()
            for i in 0..<7 {
                if daysArray[i].isEmpty, let extra = extraIterator.next() {
                    daysArray[i] = extra
                }
            }
        } else if daysArray.count < 35 {
            daysArray += [String](repeating: "", count: 35 - daysArray.count)
        }

        self.days = stride(from: 0, to: daysArray.count, by: 7).map {
            Array(daysArray[$0 ..< min($0 + 7, daysArray.count)])
        }
    }
    
    func increaseMonth() {
        if month == 12 {
            month = 1
            year += 1
        }else {
            month += 1
        }
        loadData()
    }
    
    func decreseMonth() {
        if month == 1 {
            month = 12
            year -= 1
        }else {
            month -= 1
        }
        loadData()
    }
}
