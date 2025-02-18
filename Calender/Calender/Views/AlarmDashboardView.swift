//
//  AlarmDashboardView.swift
//  Calender
//
//  Created by Apple on 17/02/25.
//

import SwiftUI

struct AlarmDashboardView: View {
    
    @StateObject var alarmVM: AlarmDashboardVM = AlarmDashboardVM()
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 8), GridItem(.flexible(), spacing: 8)]){
                        ForEach(0..<alarmVM.count, id: \.self) { index in
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.white)
                                    .frame(height: 160)
                                    .shadow(color: .black, radius: 3, x: 3, y: 3)
                                    
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Work")
                                        .font(.headline)
                                        .fontWeight(.medium)
                                    
                                    Text("08:30 AM")
                                        .font(.system(size: 30))
                                    
                                    Text("Everyday")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    
                                    Toggle("", isOn: $alarmVM.isOn)
                                    
                                }
                                .padding()
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
                        AlarmClockView()
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

