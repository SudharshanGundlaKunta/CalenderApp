//
//  ThirdApproach.swift
//  Calender
//
//  Created by Apple on 11/02/25.
//

import SwiftUI

struct CalenderDashboard: View {
    
    @StateObject var viewModel = CalenderDashboardViewModel()
    @State var openDetailBottomSheet = false
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                
                Image(systemName: "chevron.left")
                    .font(.title2.bold())
                    .padding(.bottom)
                    .onTapGesture {
                        withAnimation {
                            viewModel.decreseMonth()
                        }
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
                        withAnimation {
                            viewModel.increaseMonth()
                        }
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
                                let randomNum = Int.random(in: 1...3)
                                Image("")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(4)
                                    .scaledToFit()
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
                                            .fill(
                                                viewModel.days[rowIndex][colIndex].isEmpty ? Color.clear : (colIndex == 0 ? Color.red.opacity(0.4) : Color.blue.opacity(0.1))
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

                                
#Preview {
    CalenderDashboard()
}
