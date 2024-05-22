//
//  AudioPlayer.swift
//  MuiscTempoWithHR
//
//  Created by Zach on 5/20/24.
//

import Foundation
import AVFoundation

class AudioPlayer: NSObject {
    private var player: AVAudioPlayer?
    private var songURLs: [URL]
    private var currentSongIndex: Int
    
    
    init(songURLs: [URL]) {
        self.songURLs = songURLs
        self.currentSongIndex = 0
        
        super.init()
        
        player = AVAudioPlayer()
        player?.delegate = self
        player?.enableRate = true
        loadCurrentSong()
    }
    
    func setSongURLs(urls: [URL]){
        self.songURLs = urls
    }
    private func loadCurrentSong() {
        guard currentSongIndex >= 0 && currentSongIndex < songURLs.count else {
            print("Invalid current song index.")
            return
        }
        
        let songURL = songURLs[currentSongIndex]
        do {
            // Initialize AVAudioPlayer with song URL
            player = try AVAudioPlayer(contentsOf: songURL)
            player?.prepareToPlay()
        } catch {
            print("Error initializing AVAudioPlayer:", error)
        }
    }
    
    func pauseSong() {
        player?.pause()
    }
    
    func playSong() {
        player?.play()
    }
    
    func stopAudio() {
        player?.stop()
        player?.currentTime = 0 // Reset playback to beginning
    }
    
    func restartSong(){
        player?.stop()
        player?.currentTime = 0
        player?.play()
    }
    
    func setTempo(tempo: Float){
        player?.rate = tempo
    }
    
    func skipToNextSong() {
            currentSongIndex += 1
            if currentSongIndex >= songURLs.count {
                currentSongIndex = 0 // Loop back to the first song
            }
            loadCurrentSong()
            playSong()
        }
}

extension AudioPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("AUDIO PLAYER FINISHED SONG")
        skipToNextSong()
    }
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("AUDIO PLAYER DECODE ERROR")
    }
    func audioPlayerBeginInterruption(_ player: AVAudioPlayer) {
        print("AUDIO SESSION INTERRUPTED")
    }
    func audioPlayerEndInterruption(_ player: AVAudioPlayer, withOptions flags: Int) {
        print("AUDIO SESSION UNINTERRUPTED")
    }
}
