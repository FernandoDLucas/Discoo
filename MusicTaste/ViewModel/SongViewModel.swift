//
//  SongViewModel.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//

import Foundation

class SongViewModel {
    
    let song : Song
    
    let repository = SongRepository()
    
    init(_ song: Song) {
        self.song = song
    }
}

extension SongViewModel {
    public func saveSong() {
        _ = repository.service.save()
    }
    
    func didUpdateTextField(txt: String) {
        self.song.review = txt
        saveSong()
    }
}
