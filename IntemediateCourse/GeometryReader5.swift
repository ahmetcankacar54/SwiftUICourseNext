//
//  GeometryReader5.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 23.03.2024.
//

import SwiftUI

struct GeometryReader5: View {
    var body: some View {
        // Try not to use GeometryReader in your app
        // If you can't do it without geometry reader, use as less as possible
        // Because it will consume resources a lot
        
//        GeometryReader { geometry in
//            HStack {
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: geometry.size.width * 0.6666)
//                Rectangle()
//                    .fill(Color.yellow)
//            }
//            .ignoresSafeArea()
//        }
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 20),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                            
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                    .foregroundStyle(LinearGradient(colors: [Color.red, Color.purple], startPoint: .trailing, endPoint: .leading))
                }
            }
        }
        
    }
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
}

struct GeometryReader5_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader5()
    }
}
