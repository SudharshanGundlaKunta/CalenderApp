//
//  AlarmDashboardView.swift
//  Calender
//
//  Created by Apple on 17/02/25.
//

import SwiftUI

struct AlarmDashboardView: View {
    
    @StateObject var alarmVM: AlarmDashboardVM = AlarmDashboardVM()
    @State var times: [AlarmModel] = []
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 8)/*, GridItem(.flexible(), spacing: 8)*/]){
                        ForEach(0..<times.count, id: \.self) { index in
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.white)
                                    .frame(height: 160)
                                    .shadow(color: .black, radius: 3, x: 3, y: 3)
                                    
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(times[index].label)
                                        .font(.headline)
                                        .fontWeight(.medium)
                                    
                                    Text(times[index].time)
                                        .font(.system(size: 30))
                                    
                                    Text(times[index].frequency)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    
                                    Toggle("", isOn: $alarmVM.isOn)
                                    
                                }
                                .padding()
                            }
                            .onTapGesture {
                                LocalNotificationManager.shared.scheduleNotification()
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Alarm")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AlarmClockView(){ time in
                            self.times.append(time)
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    AlarmDashboardView()
}

