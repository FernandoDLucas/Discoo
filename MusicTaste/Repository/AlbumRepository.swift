//
//  AlbumRepository.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//

import Foundation

class AlbumRepository: Repository {
    
    typealias Object = Album
    typealias ObjectDTO = AlbumDTO

    let service = CoreDataService<Album>()
    var albuns: [Album] = []

    func getAll() -> [Album] {
        guard let albuns = service.fetchAll() else { return self.albuns }
        self.albuns = albuns
        return albuns
    }
    
    func add(object: AlbumDTO) -> Album? {
        let album = service.new()
        album?.name = object.name
        album?.artist = object.artist
        album?.artwork = object.artwork
        album?.year = object.year
        if service.save() {return album}
        return nil
    }
    
    func addSong(title: String, album: Album) -> Album? {
        return nil
    }
}
