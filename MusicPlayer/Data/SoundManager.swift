//
//  SoundManager.swift
//  MusicPlayer
//
//  Created by Markus Wirtz on 07.10.24.
//

import Foundation
import AVFoundation

class SoundManager {
    var audioPlayer: AVPlayer?

    func playSound(sound: String){
        if let url = URL(string: sound) {
            self.audioPlayer = AVPlayer(url: url)
            self.audioPlayer?.play()
        }
    }
    
    func stopSound(){
        self.audioPlayer?.pause()
    }
}
