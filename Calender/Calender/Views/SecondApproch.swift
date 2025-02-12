//
//  SecondApproch.swift
//  Calender
//
//  Created by Apple on 11/02/25.
//

import SwiftUI


struct CalendarView: View {
    private let calendar: Calendar = {
        var cal = Calendar(identifier: .gregorian)
        cal.firstWeekday = 1 // Sunday
        return cal
    }()
    
    private let weekdays = ["ఆది", "సోమ", "మంగళ", "బుధ", "గురు", "శుక్ర", "శని"]
    private let days: [[String]]
    
    init() {
        // Calculate days for January 2024
        let dateComponents = DateComponents(year: 2024, month: 2)
        guard let startDate = calendar.date(from: dateComponents),
              let range = calendar.range(of: .day, in: .month, for: startDate) else {
            fatalError("Invalid date components")
        }
        
        let firstDayWeekday = calendar.component(.weekday, from: startDate)
        let emptyCells = (firstDayWeekday - 1) % 7
        let totalDays = range.count
        
        var daysArray = [String](repeating: "", count: emptyCells)
        daysArray += (1...totalDays).map { String($0) }
        let remainingCells = 5 * 7 - daysArray.count
        daysArray += [String](repeating: "", count: remainingCells)
        
        self.days = stride(from: 0, to: daysArray.count, by: 7).map {
            Array(daysArray[$0 ..< min($0 + 7, daysArray.count)])
        }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text("January 2024")
                .font(.title2.bold())
                .padding(.bottom)
            HStack{
                // Weekdays header
                VStack(spacing: 8) {
                    ForEach(weekdays, id: \.self) { day in
                        Text(day)
                            .frame(width: 50, height: 50)
                            //.frame(maxWidth: .infinity)
                            //.padding(.vertical, 8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(4)
                    }
                }
                .font(.subheadline.bold())
                
                // Dates grid
                ForEach(days.indices, id: \.self) { rowIndex in
                    VStack(spacing: 8) {
                        ForEach(days[rowIndex].indices, id: \.self) { colIndex in
                            Text(days[rowIndex][colIndex])
                                .frame(width: 50, height: 50)
                                //.frame(maxWidth: .infinity, minHeight: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(days[rowIndex][colIndex].isEmpty ? Color.clear : Color.blue.opacity(0.1))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                        }
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
        .padding()
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
