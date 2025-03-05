//
//  AlarmClockView.swift
//  Calender
//
//  Created by Apple on 18/02/25.
//

import SwiftUI

struct AlarmClockView: View {
    
    @StateObject var clockVM: AlarmClockVM = AlarmClockVM()
    @Environment(\.presentationMode) var dismiss
    var save: (AlarmModel) -> ()

    var body: some View {
        VStack {
            GeometryReader { geometry in
                let size = min(geometry.size.width, geometry.size.height)
                let center = CGPoint(x: size / 2, y: size / 2)
                
                ZStack {
                    // Clock face outline.
                    Circle()
                        .stroke(Color.black, lineWidth: 5)
                        .shadow(color: .black, radius: 10, x: 10, y: 10)
                        
                    // Numbers 1 to 12 around the clock.
                    ForEach(1..<13) { i in
                        let angle = Angle.degrees(Double(i) * 30 - 90)
                        let numberRadius = size / 2.5
                        let x = center.x + cos(angle.radians) * numberRadius
                        let y = center.y + sin(angle.radians) * numberRadius
                        Text("\(i)")
                            .font(.headline)
                            .position(x: x, y: y)
                            
                    }
                    
                    // Hour hand (blue) with arrow shape.
                    ArrowHand(handLength: size / 3, handWidth: 8)
                        .fill(Color.black)
                        .rotationEffect(clockVM.hourArrowAngle)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    clockVM.onHoursDrag(value: value, center: center)
                                }
                                .onEnded { _ in
                                    clockVM.hourHandOffset = nil
                                }
                        )
                    
                    // Minute hand (red) with arrow shape.
                    ArrowHand(handLength: size / 2.5, handWidth: 4)
                        .fill(Color.accentColor)
                        .rotationEffect(clockVM.minuteArrowAngle)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    clockVM.onMinutesDrag(value: value, center: center)
                                }
                                .onEnded { _ in
                                    clockVM.minuteHandOffset = nil
                                }
                        )
                    
                    Circle()
                        .frame(width: 15, height: 15)
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: 5, height: 5)
                        
                }
                .frame(width: size, height: size)
            }
            .aspectRatio(1, contentMode: .fit)
            .padding(.all, 24)
            
            HStack(spacing: 8) {
                Text(String(format: "%02d : %02d", clockVM.hours, clockVM.minutes))
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding(.leading, 16)
                    .onTapGesture {
                        
                    }
                
                Menu {
                    Button("AM", action: {
                        clockVM.amorpm = "AM"
                    })
                    Button("PM", action: {
                        clockVM.amorpm = "PM"
                    })
                } label: {
                    Text(clockVM.amorpm)
                        .underline()
                }
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.red)
                
                
                
            }
            
            Spacer()
            
            ScrollView {
                VStack(spacing: 16){
                    
                    Divider()
                    HStack {
                        Text("Label")
                        Spacer()
                        Menu{
                            Button("Work", action: {
                                clockVM.label = "Work"
                            })
                            Button("Personal", action: {
                                clockVM.label = "Personal"
                            })
                            
                        } label: {
                            Text(clockVM.label)
                                .underline()
                        }
                        .foregroundColor(.blue)
                    }
                    
                    Divider()
                    HStack {
                        Text("Frequency")
                        Spacer()
                        Menu{
                            Button("Daily", action: {
                                clockVM.frequency = "Daily"
                            })
                            Button("Custom", action: {
                                clockVM.frequency = "Custom"
                            })
                            Button("Weekdays", action: {
                                clockVM.frequency = "Weekdays"
                            })
                        } label: {
                            Text(clockVM.frequency)
                                .underline()
                        }
                        .foregroundColor(.blue)
                    }
                    Divider()
                    HStack {
                        Text("Type")
                        Spacer()
                        Menu{
                            Button("Click annd stop", action: {
                                clockVM.type = "Click annd stop"
                            })
                            Button("Image Recognisation", action: {
                                clockVM.type = "Image Recognisation"
                            })
                            Button("Puzzle Solver", action: {
                                clockVM.type = "Puzzle Solver"
                            })
                            
                        } label: {
                            Text(clockVM.type)
                                .underline()
                        }
                        .foregroundColor(.blue)
                    }
                    
                    Divider()
                    HStack {
                        Text("Alarm Sound")
                        Spacer()
                        Menu{
                            Button("Rains", action: {
                                clockVM.alarmSound = "Rains"
                            })
                            Button("Imagine dragons", action: {
                                clockVM.alarmSound = "Imagine dragons"
                            })
                            Button("Dont mess", action: {
                                clockVM.alarmSound = "Dont mess"
                            })
                            
                        } label: {
                            Text(clockVM.alarmSound)
                                .underline()
                        }
                        .foregroundColor(.blue)
                    }
                    
                    Divider()
                    HStack {
                        Text("Snooze")
                        Spacer()
                        Menu{
                            Button("10 min", action: {
                                clockVM.snoozeAfter = "10 min"
                            })
                            Button("15 min", action: {
                                clockVM.snoozeAfter = "15 min"
                            })
                            Button("20 min", action: {
                                clockVM.snoozeAfter = "20 min"
                            })
                            
                        } label: {
                            Text(clockVM.snoozeAfter)
                                .underline()
                        }
                        .foregroundColor(.blue)
                    }
                    
                    Divider()
                    HStack {
                        Text("Vibrate")
                        Spacer()
                        Menu{
                            Button("Yes", action: {
                                clockVM.vibrate = true
                            })
                            Button("No", action: {
                                clockVM.vibrate = false
                            })
                            
                        } label: {
                            Text(clockVM.vibrate ? "Yes" : "No")
                                .underline()
                        }
                        .foregroundColor(.blue)
                    }
                }
                .font(.system(size: 20, weight: .semibold))
                .padding()
                
            }
            .navigationTitle("Select Time")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        save(clockVM.getCalenderModelData())
                        dismiss.wrappedValue.dismiss()
                    }
                }
            }
        }
        .onAppear {
            clockVM.onAppear()
        }
    }
}


#Preview(body: {
    NavigationView{
        AlarmClockView() {_ in }
    }
})
