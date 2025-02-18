//
//  AlarmClockView.swift
//  Calender
//
//  Created by Apple on 18/02/25.
//

import SwiftUI

struct AlarmClockView: View {
    // Total minutes since 12:00 (in a 12-hour cycle).
    // For example, 90 represents 1:30.
    @State private var totalMinutes: Double = 0
    @State private var hourHandOffset: Double? = nil
    @State private var minuteHandOffset: Double? = nil

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
                        .fill(Color.blue)
                        .rotationEffect(Angle.degrees((totalMinutes / 60) * 30))
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let vector = CGVector(dx: value.location.x - center.x,
                                                            dy: value.location.y - center.y)
                                    var angleInDegrees = atan2(vector.dy, vector.dx) * 180 / .pi
                                    if angleInDegrees < 0 { angleInDegrees += 360 }
                                    
                                    // On first update, capture the offset.
                                    if hourHandOffset == nil {
                                        let currentAngle = (totalMinutes / 60) * 30
                                        hourHandOffset = angleInDegrees - currentAngle
                                    }
                                    // Use the offset to update the hand angle smoothly.
                                    let newAngle = angleInDegrees - (hourHandOffset ?? 0)
                                    totalMinutes = (newAngle / 30) * 60
                                }
                                .onEnded { _ in
                                    hourHandOffset = nil
                                }
                        )
                    
                    // Minute hand (red) with arrow shape.
                    ArrowHand(handLength: size / 2.5, handWidth: 4)
                        .fill(Color.red)
                        .rotationEffect(Angle.degrees((totalMinutes.truncatingRemainder(dividingBy: 60)) * 6))
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let vector = CGVector(dx: value.location.x - center.x,
                                                            dy: value.location.y - center.y)
                                    var angleInDegrees = atan2(vector.dy, vector.dx) * 180 / .pi
                                    if angleInDegrees < 0 { angleInDegrees += 360 }
                                    
                                    // Capture initial offset for the minute hand.
                                    if minuteHandOffset == nil {
                                        let currentMinute = totalMinutes.truncatingRemainder(dividingBy: 60)
                                        let currentAngle = currentMinute * 6
                                        minuteHandOffset = angleInDegrees - currentAngle
                                    }
                                    
                                    let newAngle = angleInDegrees - (minuteHandOffset ?? 0)
                                    let newMinute = newAngle / 6
                                    
                                    let currentMinute = totalMinutes.truncatingRemainder(dividingBy: 60)
                                    var delta = newMinute - currentMinute
                                    // Handle wrap-around.
                                    if delta > 30 { delta -= 60 }
                                    else if delta < -30 { delta += 60 }
                                    
                                    totalMinutes += delta
                                }
                                .onEnded { _ in
                                    minuteHandOffset = nil
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
            .padding(.all, 64)
            
            // Display the alarm time in HH:MM format.
            let hours = Int(totalMinutes / 60) % 12
            let minutes = Int(totalMinutes.truncatingRemainder(dividingBy: 60))
            Text(String(format: "Alarm Time: %02d:%02d", hours, minutes))
                .font(.headline)
                .padding()
            
            Spacer()
            
            
        }
        .onAppear {
            // Initialize to the current system time (in a 12-hour cycle).
            let now = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: now) % 12
            let minute = calendar.component(.minute, from: now)
            totalMinutes = Double(hour * 60 + minute)
        }
    }
}
