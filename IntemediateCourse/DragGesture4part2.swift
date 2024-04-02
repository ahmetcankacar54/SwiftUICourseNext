//
//  DragGesture4part2.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 23.03.2024.
//

import SwiftUI

struct DragGesture4part2: View {
    
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.83
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    
    var body: some View {
        
        ZStack {
            Color.mint.ignoresSafeArea()
            
            SignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            currentDragOffsetY = value.translation.height
                        })
                        .onEnded({ value in
                            
                            withAnimation(.spring()) {
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -startingOffsetY
                                } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                    endingOffsetY = 0
                                }
                                currentDragOffsetY = 0
                                
                            }
                        })
                )
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct DragGesture4part2_Previews: PreviewProvider {
    static var previews: some View {
        DragGesture4part2()
    }
}

struct SignUpView: View {
    var body: some View {
        VStack (spacing: 20) {
            Image(systemName: "chevron.up")
                .padding(.top)
            
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "car")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("This is the description of the car rental service application. This is best and secure app for rent a car at anywhere in the world.")
                .multilineTextAlignment(.center)
            
            Text("create an account".uppercased())
                .foregroundColor(.white)
                .font(.headline)
                .fontWeight(.semibold)
                .padding()
                .padding(.horizontal)
                .background(Color.black.cornerRadius(10))
            Spacer()
            
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(25)
    }
}
