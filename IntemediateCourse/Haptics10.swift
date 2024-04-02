//
//  Haptics10.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 24.03.2024.
//

import SwiftUI

class HapticManager {
    
    static let instance = HapticManager() // Singleton
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct Haptics10: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("success") {
                HapticManager.instance.notification(type: .success)
            }
            Button("warning") {
                HapticManager.instance.notification(type: .warning)
            }
            Button("error") {
                HapticManager.instance.notification(type: .error)
            }
            Spacer()
            Button("soft") {
                HapticManager.instance.impact(style: .soft)
            }
            Button("light") {
                HapticManager.instance.impact(style: .light)
            }
            Button("medium") {
                HapticManager.instance.impact(style: .medium)
            }
            Button("rigid") {
                HapticManager.instance.impact(style: .rigid)
            }
            Button("heavy") {
                HapticManager.instance.impact(style: .heavy)
            }
        }
    }
}

struct Haptics10_Previews: PreviewProvider {
    static var previews: some View {
        Haptics10()
    }
}
