//
//  AlbumViewModel.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//

import Foundation

class AlbumViewModel {
    
    let album : Album
    
    let repository = AlbumRepository()
    
    let songRepository = SongRepository()
    
    var songs = [SongViewModel]()
    
    var handleUpdate: (() -> Void)?

    init(album: Album) {
        self.album = album
    }
}

extension AlbumViewModel{
    public var name: String? {
        return album.name
    }
    
    public var artist: String? {
        return album.artist
    }
    
    public var artwork: Data? {
        return album.artwork
    }
    
    public var year: Int32 {
        return album.year
    }
}

extension  AlbumViewModel{
    
    public func getAll() {
        let array = album.getSongs()
        self.songs = array.map {
            SongViewModel.init($0)
        }
        self.handleUpdate?()
    }
    
    public var numberOfSongs : Int{
        return songs.count
    }
    public func addSong(title: String) {
        _ = songRepository.addSong(title: title, album: self.album)
        self.handleUpdate?()
    }
    
    public func songForRow(at index: Int) -> Song{
        return songs[index].song
    }
}
