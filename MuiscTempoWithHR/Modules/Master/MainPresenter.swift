//
//  MainPresenter.swift
//  MuiscTempoWithHR
//
//  Created by Zach on 5/20/24.
//

import Foundation
import UIKit

protocol MainDelegate: AnyObject {
    func viewDidLoad()
}

protocol MainDataSource: AnyObject {
    var viewModel: MainViewModel { get }
    var player: AudioPlayer { get }
    func playSong()
    func pauseSong()
    func restartSong()
    func setTempo(tempo: Float)
}

class MainPresenter {
    private weak var view: MainView?
    var viewModel: MainViewModel
    var player: AudioPlayer
    
    init(view: MainView, songURLs: [URL]){
        self.view = view
        viewModel = MainViewModel()
        player = AudioPlayer(songURLs: songURLs)
    }
}

extension MainPresenter: MainDelegate {
    func viewDidLoad() {
        playSong()
    }
}

extension MainPresenter: MainDataSource {
    func playSong(){
        player.playSong()
    }
    
    func pauseSong(){
        player.pauseSong()
    }
    
    func restartSong(){
        player.restartSong()
    }
    
    func setTempo(tempo: Float){
        player.setTempo(tempo: tempo)
    }
    
    
    
}
