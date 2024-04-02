//
//  RotationGesture3.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 23.03.2024.
//

import SwiftUI

struct RotationGesture3: View {
    
    @State var angle: Angle = Angle(degrees: 0)
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.title)
            .foregroundColor(.white)
            .padding(50)
            .background(Color.blue.cornerRadius(20))
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged { value in
                        angle = value
                    }
                    .onEnded { value in
                        withAnimation(.easeInOut) {
                            angle = Angle(degrees: 0)
                        }
                        
                    }
            )
    }
}

struct RotationGesture3_Previews: PreviewProvider {
    static var previews: some View {
        RotationGesture3()
    }
}
