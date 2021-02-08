//
//  SongRepository.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 05/02/21.
//

import Foundation

class SongRepository: Repository {
    
    typealias Object = Song
    typealias ObjectDTO = AlbumDTO

    let service = CoreDataService<Song>()
    var songs: [Song] = []

    func getAll() -> [Song] {
        guard let songs = service.fetchAll() else { return self.songs }
        self.songs = songs
        return songs
    }
    
    func add(object: AlbumDTO) -> Song? {
        return nil
    }
    
    func addSong(title: String) -> Song? {
        let song = service.new()
        song?.name = title
        if service.save() {return song}
        return nil
    }
}
