//
//  ThirdApproach.swift
//  Calender
//
//  Created by Apple on 11/02/25.
//

import SwiftUI

struct CalendarView2: View {
    
    @StateObject var viewModel = CalenderViewModel()
    @State var openDetailBottomSheet = false
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                
                Image(systemName: "chevron.left")
                    .font(.title2.bold())
                    .padding(.bottom)
                    .onTapGesture {
                        viewModel.decreseMonth()
                    }
                Spacer()
                Text("\(viewModel.teluguMonths[viewModel.month - 1]) - \(viewModel.year.description)")
                    .font(.title2.bold())
                    .padding(.bottom)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.title2.bold())
                    .padding(.bottom)
                    .onTapGesture {
                        viewModel.increaseMonth()
                    }
            }
            HStack{
                
                VStack(spacing: 8) {
                    ForEach(viewModel.weekdays, id: \.self) { day in
                        Text(day)
                            .frame(width: 50, height: 50)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(4)
                    }
                }
                .font(.subheadline.bold())
                
                
                ForEach(viewModel.days.indices, id: \.self) { rowIndex in
                    VStack(spacing: 8) {
                        ForEach(viewModel.days[rowIndex].indices, id: \.self) { colIndex in
                            if viewModel.days[rowIndex][colIndex] == "" {
                                Image(systemName: "snowflake")
                                    .foregroundColor(.red)
                                    .frame(width: 50, height: 50)
                                    .background(
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(viewModel.days[rowIndex][colIndex].isEmpty ? Color.clear : Color.blue.opacity(0.1)
                                                 )
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                    )
                            }else {
                                Text(viewModel.days[rowIndex][colIndex])
                                    .frame(width: 50, height: 50)
                                    .background(
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(viewModel.days[rowIndex][colIndex].isEmpty ? Color.clear : Color.blue.opacity(0.1)
                                                 )
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
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
        .padding()
    }
}

class CalenderViewModel: ObservableObject {
    private let calendar: Calendar = {
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
            let arrayOfExtraDays = Array(extraDays)
            //MARK: Converting Array Slicing to array
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

                                
#Preview {
    CalendarView2()
}
