//
//  SoundEffects9.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 24.03.2024.
//

import SwiftUI
import AVKit

class SoundManager {
    
    enum SoundBoard: String {
    case tada
    case grindr
    }
    
    static let instance = SoundManager() // singleton
    
    var player: AVAudioPlayer?
    
    func playSound(sound: SoundBoard) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
}

struct SoundEffects9: View {
    
    
    var body: some View {
        VStack(spacing: 40) {
            Button("Play Sound 1") {
                SoundManager.instance.playSound(sound: .grindr)
            }
            Button("Play Sound 2") {
                SoundManager.instance.playSound(sound: .tada)
            }
        }
    }
}

struct SoundEffects9_Previews: PreviewProvider {
    static var previews: some View {
        SoundEffects9()
    }
}
