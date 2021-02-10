//
//  SongRepository.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 05/02/21.
//

import Foundation

class SongRepository {

    let service = CoreDataService<Song>()
    var songs: [Song] = []

    func addSong(title: String, album: Album) -> Song? {
        let song = service.new()
        song?.name = title
        album.addToSongs(song!)
        if service.save() {return song}
        return nil
    }

    func deleteAll() {
        guard let songs = service.fetchAll() else { return }
        songs.forEach {
            _ = delete(object: $0)
        }
    }
}

extension SongRepository: Repository {

    typealias Object = Song
    typealias ObjectDTO = AlbumDTO

    func getAll() -> [Song] {
        guard let songs = service.fetchAll() else { return self.songs }
        self.songs = songs

        return songs
    }

    func add(object: AlbumDTO) -> Song? {
        return nil
    }

    func delete(object: Song) -> Song? {
        guard let song = service.delete(object: object) else { return nil }
        return song
    }

}
