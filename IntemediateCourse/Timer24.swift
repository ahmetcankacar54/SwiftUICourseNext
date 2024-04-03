//
//  Timer24.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 3.04.2024.
//

import SwiftUI

struct Timer24: View {
    
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    
    
    // Current Time
    /*
     
     @State var currentDate: Date = Date()
     var dateFormatter: DateFormatter {
         let formatter = DateFormatter()
         formatter.timeStyle = .medium
         return formatter
     }
     */
    
    // Count Down
    /*
     @State var count: Int = 10
     @State var finishedText: String? = nil
     */
    
    // Count Down to Date
    /*
     @State var timeRemaining: String = ""
     let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
     
     func updateTimeRemaining() {
         let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: .now, to: futureDate)
         let hour = remaining.hour ?? 0
         let minute = remaining.minute ?? 0
         let second = remaining.second ?? 0
         timeRemaining = "\(hour): \(minute): \(second)"
     }
     */
    
    // Animation Counter
    @State var count: Int = 1
    
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3949197061, green: 0.475494355, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1))]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            TabView(selection: $count) {
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.red)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.yellow)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.cyan)
                    .tag(5)
            }
            .frame(height: 250)
            .tabViewStyle(PageTabViewStyle())
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.default) {
                count = count == 5 ? 1 : count + 1
            }
        })
    }
}

struct Timer24_Previews: PreviewProvider {
    static var previews: some View {
        Timer24()
    }
}
