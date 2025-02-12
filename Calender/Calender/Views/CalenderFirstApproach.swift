//
//  ContentView.swift
//  Calender
//
//  Created by Apple on 10/02/25.
//

import SwiftUI

struct CalenderFirstApproach: View {
    
    @State var openDetailsBottomSheet = false
    @State var mothDetails: MonthDetails? = LocalJsonDataManager.shared.getData()
    @State var curretIndex = 0
    
    var body: some View {
        HStack(spacing: 4.0) {
            ForEach(0..<6){ index1 in
                VStack(spacing: 4.0) {
                    ForEach(0..<7) { index2 in
                        ZStack{
                            RoundedRectangle(cornerRadius: 16.0)
                                .fill(index1 == 0 ? Color.red.opacity(0.5) : Color.white)
                                .shadow(color: .black, radius: 1, x: 0, y: 0)
                            if index1 == 0 {
                                Text(getDayName(index2))
                            }else {
                                if curretIndex < mothDetails?.days.count ?? 0{
                                    if let dayDetails = mothDetails?.days[curretIndex]{
                                        if dayDetails.day.hasPrefix(getDayName(index2)){
                                            Text(dayDetails.date)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    func getDayName(_ dayNum: Int) -> String {
        switch dayNum {
        case 0:
            return "ఆది"
        case 1:
            return "సోమ"
        case 2:
            return "మంగళ"
        case 3:
            return "బుధ"
        case 4:
            return "గురు"
        case 5:
            return "శుక్ర"
        case 6:
            return "శని"
        default:
            return ""
        }
    }
}

#Preview {
    CalenderFirstApproach()
}


