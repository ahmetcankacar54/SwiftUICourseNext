//
//  Mask8.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 24.03.2024.
//

import SwiftUI

struct Mask8: View {
    
    @State var rating: Int = 0
    
    var body: some View {
        ZStack {
           starsView
//                .overlay(overlayView.mask(starsView))
        }
    }
    
    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.title)
                    .foregroundColor(rating >= index ? .yellow : .gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
        }
    }
}

struct Mask8_Previews: PreviewProvider {
    static var previews: some View {
        Mask8()
    }
}
